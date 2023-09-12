defmodule GitHub.Plugin.TypedDecoder do
  @moduledoc """
  Transform map responses into well-typed structs

  In a normal client stack, the HTTP request is followed by a JSON decoder such as
  `GitHub.Plugin.JasonSerializer`. If the JSON library/plugin does not support decoding typed
  structs, then a separate step is necessary to transform the map responses into structs like
  `GitHub.Repository`.

  This module provides a two plugins: `decode_response/2` and `normalize_errors/2`, that accept no
  configuration. `decode_response/2` uses the type information available in the operation and each
  module's `__fields__/1` functions to decode the data. `normalize_errors/2` changes API error
  responses into standard `GitHub.Error` results. It is recommended to run these plugins towards
  the end of the stack, after decoding JSON responses.

  The normalized errors will be `GitHub.Error` structs with relevant reason fields where possible.

  ## Special Cases

  There are a few special cases where the decoder must make an inference about which type to use.
  If you find that you are unable to decode something, please open an issue with information about
  the operation and types involved.

  Union types often require this kind of inference. This module handles them on a case-by-case
  basis using required keys to determine the correct type. Some of these are done on a "best
  guess" basis due to a lack of official documentation.
  """
  alias GitHub.Error
  alias GitHub.Operation

  @doc """
  Decode a response body based on type information from the operation and schemas
  """
  @spec decode_response(Operation.t(), keyword) :: {:ok, Operation.t()}
  def decode_response(operation, _opts) do
    %Operation{response_body: body, response_code: code, response_types: types} = operation

    case get_type(types, code) do
      {:ok, response_type} ->
        decoded_body = do_decode(body, response_type)
        {:ok, %Operation{operation | response_body: decoded_body}}

      {:error, :not_found} ->
        {:ok, operation}
    end
  end

  defp get_type(types, code) do
    if res = Enum.find(types, fn {c, _} -> c == code end) do
      {:ok, elem(res, 1)}
    else
      {:error, :not_found}
    end
  end

  defp do_decode(value, {:array, type}), do: Enum.map(value, &do_decode(&1, type))
  defp do_decode(nil, {:nullable, _type}), do: nil
  defp do_decode(value, {:nullable, type}), do: do_decode(value, type)
  defp do_decode(value, {:union, types}), do: do_decode(value, choose_union(value, types))

  defp do_decode(%{} = value, {module, type}) do
    fields = module.__fields__(type)

    for {field_name, field_type} <- fields, reduce: struct(module) do
      decoded_value ->
        case Map.fetch(value, to_string(field_name)) do
          {:ok, field_value} ->
            decoded_field_value = do_decode(field_value, field_type)
            struct(decoded_value, [{field_name, decoded_field_value}])

          :error ->
            decoded_value
        end
    end
  end

  defp do_decode("", nil), do: nil
  defp do_decode(value, _type), do: value

  @doc """
  Change API error responses into `GitHub.Error` results
  """
  @spec normalize_errors(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def normalize_errors(%Operation{response_code: code} = operation, _opts) when code >= 400 do
    %Operation{response_body: body} = operation

    error_attributes =
      Keyword.merge(
        [
          code: code,
          operation: operation,
          source: body,
          step: {__MODULE__, :normalize_errors}
        ],
        error_attributes(code, body)
      )

    {:error, Error.new(error_attributes)}
  end

  def normalize_errors(operation, _opts), do: {:ok, operation}

  @spec error_attributes(integer | nil, any) :: keyword
  defp error_attributes(400, %{"errors" => "The version you specified" <> _ = message}) do
    [message: message, reason: :invalid_version]
  end

  # Invalid credentials
  defp error_attributes(401, %{"message" => "Bad credentials" = message}) do
    [message: message, reason: :invalid_auth]
  end

  defp error_attributes(401, %{message: "Bad credentials" = message}) do
    [message: message, reason: :invalid_auth]
  end

  # Requires authentication
  defp error_attributes(401, %{"message" => "Requires authentication" = message}) do
    [message: message, reason: :requires_auth]
  end

  defp error_attributes(401, %{message: "Requires authentication" = message}) do
    [message: message, reason: :requires_auth]
  end

  # Unauthorized
  defp error_attributes(403, %{"message" => "Must have admin rights" <> _ = message}) do
    [message: message, reason: :unauthorized]
  end

  defp error_attributes(403, %{message: "Must have admin rights" <> _ = message}) do
    [message: message, reason: :unauthorized]
  end

  # OAuth app restrictions
  defp error_attributes(403, %{"message" => "Although you appear to have" <> _ = message}) do
    [message: message, reason: :oauth_restricted]
  end

  defp error_attributes(403, %{message: "Although you appear to have" <> _ = message}) do
    [message: message, reason: :oauth_restricted]
  end

  # Rate limits
  defp error_attributes(403, %{"message" => "API rate limit exceeded" <> _ = message}) do
    [message: message, reason: :rate_limited]
  end

  defp error_attributes(403, %{message: "API rate limit exceeded" <> _ = message}) do
    [message: message, reason: :rate_limited]
  end

  defp error_attributes(403, %{"message" => "You have exceeded a secondary" <> _ = message}) do
    [message: message, reason: :rate_limited]
  end

  defp error_attributes(403, %{message: "You have exceeded a secondary" <> _ = message}) do
    [message: message, reason: :rate_limited]
  end

  # Not found
  defp error_attributes(404, _response) do
    [message: "Not Found", reason: :not_found]
  end

  defp error_attributes(_code, %{"message" => message}), do: [message: message]
  defp error_attributes(_code, %{message: message}), do: [message: message]
  defp error_attributes(_code, _response), do: [message: "Unknown Error"]

  #
  # Union Type Handlers
  #

  defp choose_union(%{}, [:map, :string]), do: :map
  defp choose_union(_value, [:map, :string]), do: :string

  defp choose_union(%{}, [:string, :map]), do: :map
  defp choose_union(_value, [:string, :map]), do: :string

  defp choose_union(value, [:string, :number]) when is_number(value), do: :number
  defp choose_union(_value, [:string, :number]), do: :string

  defp choose_union(value, [
         :map,
         {:array, :string},
         {:array, :map},
         :string
       ]) do
    cond do
      is_binary(value) ->
        :string

      is_map(value) ->
        :map

      is_list(value) ->
        case value do
          [%{} | _] -> {:array, :map}
          _else -> {:array, :string}
        end
    end
  end

  defp choose_union(value, [
         {:array, {GitHub.StarredRepository, :t}},
         {:array, {GitHub.Repository, :t}}
       ]) do
    case value do
      [%{"repo" => _}] -> {:array, {GitHub.StarredRepository, :t}}
      _else -> {:array, {GitHub.Repository, :t}}
    end
  end

  defp choose_union(value, [
         {:array, {GitHub.User, :simple}},
         {:array, {GitHub.Stargazer, :t}}
       ]) do
    case value do
      [%{"user" => _}] -> {:array, {GitHub.Stargazer, :t}}
      _else -> {:array, {GitHub.User, :simple}}
    end
  end

  defp choose_union(_value, [{GitHub.User, :private}, {GitHub.User, :public}]) do
    # Private has a superset of public fields, and they use the same struct
    {GitHub.User, :private}
  end

  defp choose_union(value, [{GitHub.Interaction.Limit.Response, :t}, :map]) do
    if Map.has_key?(value, "limit") do
      {GitHub.Interaction.Limit.Response, :t}
    else
      :map
    end
  end

  # Warning: Most of the event fields are undocumented in the spec, so this is a best guess.
  defp choose_union(value, [{GitHub.LabeledIssueEvent, :t} | _]) do
    case value do
      %{"event" => "labeled"} -> {GitHub.LabeledIssueEvent, :t}
      %{"event" => "unlabeled"} -> {GitHub.UnlabeledIssueEvent, :t}
      %{"event" => "assigned", "assigner" => _} -> {GitHub.AssignedIssueEvent, :t}
      %{"event" => "unassigned", "assigner" => _} -> {GitHub.UnassignedIssueEvent, :t}
      %{"event" => "milestoned"} -> {GitHub.MilestonedIssueEvent, :t}
      %{"event" => "demilestoned"} -> {GitHub.DemilestonedIssueEvent, :t}
      %{"event" => "renamed"} -> {GitHub.RenamedIssueEvent, :t}
      %{"event" => "review_requested"} -> {GitHub.ReviewRequestedIssueEvent, :t}
      %{"event" => "review_request_removed"} -> {GitHub.ReviewRequestRemovedIssueEvent, :t}
      %{"event" => "review_dismissed"} -> {GitHub.ReviewDismissedIssueEvent, :t}
      %{"event" => "locked"} -> {GitHub.LockedIssueEvent, :t}
      %{"event" => "added_to_project"} -> {GitHub.AddedToProjectIssueEvent, :t}
      %{"event" => "moved_column_in_project"} -> {GitHub.MovedColumnInProjectIssueEvent, :t}
      %{"event" => "removed_from_project"} -> {GitHub.RemovedFromProjectIssueEvent, :t}
      %{"event" => "converted_note_to_issue"} -> {GitHub.ConvertedNoteToIssueIssueEvent, :t}
      %{"event" => "commented"} -> {GitHub.Timeline.CommentEvent, :t}
      %{"event" => "cross-referenced"} -> {GitHub.Timeline.CrossReferencedEvent, :t}
      %{"event" => "committed"} -> {GitHub.Timeline.CommittedEvent, :t}
      %{"event" => "reviewed"} -> {GitHub.Timeline.ReviewedEvent, :t}
      %{"event" => "commented", "commit_id" => _} -> {GitHub.Timeline.CommitCommentedEvent, :t}
      %{"event" => "commented", "comments" => _} -> {GitHub.Timeline.LineCommentedEvent, :t}
      %{"event" => "assigned"} -> {GitHub.Timeline.AssignedIssueEvent, :t}
      %{"event" => "unassigned"} -> {GitHub.Timeline.UnassignedIssueEvent, :t}
      %{"event" => _, "state_reason" => "_"} -> {GitHub.StateChangeIssueEvent, :t}
    end
  end

  defp choose_union(value, [{GitHub.ValidationError, :t}, {GitHub.ValidationError, :simple}]) do
    case value do
      %{"errors" => [%{} | _]} -> {GitHub.ValidationError, :t}
      _else -> {GitHub.ValidationError, :simple}
    end
  end

  defp choose_union(value, [
         {:array, :map},
         {GitHub.Content.File, :t},
         {GitHub.Content.Symlink, :t},
         {GitHub.Content.Submodule, :t}
       ]) do
    case value do
      list when is_list(list) -> {:array, :map}
      %{"content" => _} -> {GitHub.Content.File, :t}
      %{"target" => _} -> {GitHub.Content.Symlink, :t}
      %{"submodule_git_url" => _} -> {GitHub.Content.Submodule, :t}
    end
  end

  defp choose_union(value, [{GitHub.Repository.Rule.Creation, :t} | _]) do
    case value do
      %{"type" => "creation"} ->
        {GitHub.Repository.Rule.Creation, :t}

      %{"type" => "update"} ->
        {GitHub.Repository.Rule.Update, :t}

      %{"type" => "deletion"} ->
        {GitHub.Repository.Rule.Deletion, :t}

      %{"type" => "required_linear_history"} ->
        {GitHub.Repository.Rule.RequiredLinearHistory, :t}

      %{"type" => "required_deployments"} ->
        {GitHub.Repository.Rule.RequiredDeployments, :t}

      %{"type" => "required_signatures"} ->
        {GitHub.Repository.Rule.RequiredSignatures, :t}

      %{"type" => "pull_request"} ->
        {GitHub.Repository.Rule.PullRequest, :t}

      %{"type" => "required_status_checks"} ->
        {GitHub.Repository.Rule.RequiredStatusChecks, :t}

      %{"type" => "non_fast_forward"} ->
        {GitHub.Repository.Rule.NonFastForward, :t}

      %{"type" => "commit_message_pattern"} ->
        {GitHub.Repository.Rule.CommitMessagePattern, :t}

      %{"type" => "commit_author_email_pattern"} ->
        {GitHub.Repository.Rule.CommitAuthorEmailPattern, :t}

      %{"type" => "committer_email_pattern"} ->
        {GitHub.Repository.Rule.CommitterEmailPattern, :t}

      %{"type" => "branch_name_pattern"} ->
        {GitHub.Repository.Rule.BranchNamePattern, :t}

      %{"type" => "tag_name_pattern"} ->
        {GitHub.Repository.Rule.TagNamePattern, :t}
    end
  end

  defp choose_union(value, [{GitHub.User, :simple}, {GitHub.Enterprise, :t}]) do
    case value do
      %{"slug" => _} -> {GitHub.Enterprise, :t}
      _else -> {GitHub.User, :simple}
    end
  end

  defp choose_union(value, [
         {GitHub.SecretScanning.LocationCommit, :t},
         {GitHub.SecretScanning.LocationIssueTitle, :t},
         {GitHub.SecretScanning.LocationIssueBody, :t},
         {GitHub.SecretScanning.LocationIssueComment, :t}
       ]) do
    case value do
      %{"commit_sha" => _} -> {GitHub.SecretScanning.LocationCommit, :t}
      %{"issue_title_url" => _} -> {GitHub.SecretScanning.LocationIssueTitle, :t}
      %{"issue_body_url" => _} -> {GitHub.SecretScanning.LocationIssueBody, :t}
      %{"issue_comment_url" => _} -> {GitHub.SecretScanning.LocationIssueComment, :t}
    end
  end

  defp choose_union(_value, types) do
    raise "TypedDecoder: Unable to decode union type #{inspect(types)}; not implemented"
  end
end
