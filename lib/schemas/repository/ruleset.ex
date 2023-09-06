defmodule GitHub.Repository.Ruleset do
  @moduledoc """
  Provides struct and type for RepositoryRuleset
  """

  @type t :: %__MODULE__{
          __info__: map,
          _links: map | nil,
          bypass_actors: [GitHub.Repository.Ruleset.BypassActor.t()] | nil,
          conditions: (map | GitHub.Repository.Ruleset.Conditions.t()) | nil,
          created_at: String.t() | nil,
          current_user_can_bypass: String.t() | nil,
          enforcement: String.t(),
          id: integer,
          name: String.t(),
          node_id: String.t() | nil,
          rules:
            [
              GitHub.Repository.Rule.BranchNamePattern.t()
              | GitHub.Repository.Rule.CommitAuthorEmailPattern.t()
              | GitHub.Repository.Rule.CommitMessagePattern.t()
              | GitHub.Repository.Rule.CommitterEmailPattern.t()
              | GitHub.Repository.Rule.Creation.t()
              | GitHub.Repository.Rule.Deletion.t()
              | GitHub.Repository.Rule.NonFastForward.t()
              | GitHub.Repository.Rule.PullRequest.t()
              | GitHub.Repository.Rule.RequiredDeployments.t()
              | GitHub.Repository.Rule.RequiredLinearHistory.t()
              | GitHub.Repository.Rule.RequiredSignatures.t()
              | GitHub.Repository.Rule.RequiredStatusChecks.t()
              | GitHub.Repository.Rule.TagNamePattern.t()
              | GitHub.Repository.Rule.Update.t()
            ]
            | nil,
          source: String.t(),
          source_type: String.t() | nil,
          target: String.t() | nil,
          updated_at: String.t() | nil
        }

  defstruct [
    :__info__,
    :_links,
    :bypass_actors,
    :conditions,
    :created_at,
    :current_user_can_bypass,
    :enforcement,
    :id,
    :name,
    :node_id,
    :rules,
    :source,
    :source_type,
    :target,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      _links: :map,
      bypass_actors: {:array, {GitHub.Repository.Ruleset.BypassActor, :t}},
      conditions: {:union, [{GitHub.Repository.Ruleset.Conditions, :t}, :map]},
      created_at: :string,
      current_user_can_bypass: :string,
      enforcement: :string,
      id: :integer,
      name: :string,
      node_id: :string,
      rules:
        {:array,
         {:union,
          [
            {GitHub.Repository.Rule.Creation, :t},
            {GitHub.Repository.Rule.Update, :t},
            {GitHub.Repository.Rule.Deletion, :t},
            {GitHub.Repository.Rule.RequiredLinearHistory, :t},
            {GitHub.Repository.Rule.RequiredDeployments, :t},
            {GitHub.Repository.Rule.RequiredSignatures, :t},
            {GitHub.Repository.Rule.PullRequest, :t},
            {GitHub.Repository.Rule.RequiredStatusChecks, :t},
            {GitHub.Repository.Rule.NonFastForward, :t},
            {GitHub.Repository.Rule.CommitMessagePattern, :t},
            {GitHub.Repository.Rule.CommitAuthorEmailPattern, :t},
            {GitHub.Repository.Rule.CommitterEmailPattern, :t},
            {GitHub.Repository.Rule.BranchNamePattern, :t},
            {GitHub.Repository.Rule.TagNamePattern, :t}
          ]}},
      source: :string,
      source_type: :string,
      target: :string,
      updated_at: :string
    ]
  end
end
