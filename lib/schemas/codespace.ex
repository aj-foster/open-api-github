defmodule GitHub.Codespace do
  @moduledoc """
  Provides struct and types for a Codespace
  """
  use GitHub.Encoder

  @type codespace_machines_for_authenticated_user_200_json_resp :: %__MODULE__{
          __info__: map,
          machines: [GitHub.Codespace.Machine.t()],
          total_count: integer
        }

  @type get_codespaces_for_user_in_org_200_json_resp :: %__MODULE__{
          __info__: map,
          codespaces: [GitHub.Codespace.t()],
          total_count: integer
        }

  @type list_devcontainers_in_repository_for_authenticated_user_200_json_resp :: %__MODULE__{
          __info__: map,
          devcontainers: [
            GitHub.Codespace.Devcontainers.list_devcontainers_in_repository_for_authenticated_user_200_json_resp()
          ],
          total_count: integer
        }

  @type list_for_authenticated_user_200_json_resp :: %__MODULE__{
          __info__: map,
          codespaces: [GitHub.Codespace.t()],
          total_count: integer
        }

  @type list_in_organization_200_json_resp :: %__MODULE__{
          __info__: map,
          codespaces: [GitHub.Codespace.t()],
          total_count: integer
        }

  @type list_in_repository_for_authenticated_user_200_json_resp :: %__MODULE__{
          __info__: map,
          codespaces: [GitHub.Codespace.t()],
          total_count: integer
        }

  @type list_org_secrets_200_json_resp :: %__MODULE__{
          __info__: map,
          secrets: [GitHub.Codespace.OrgSecret.t()],
          total_count: integer
        }

  @type list_repo_secrets_200_json_resp :: %__MODULE__{
          __info__: map,
          secrets: [GitHub.RepoCodespacesSecret.t()],
          total_count: integer
        }

  @type list_repositories_for_secret_for_authenticated_user_200_json_resp :: %__MODULE__{
          __info__: map,
          repositories: [GitHub.Repository.minimal()],
          total_count: integer
        }

  @type list_secrets_for_authenticated_user_200_json_resp :: %__MODULE__{
          __info__: map,
          secrets: [GitHub.Codespace.Secret.t()],
          total_count: integer
        }

  @type list_selected_repos_for_org_secret_200_json_resp :: %__MODULE__{
          __info__: map,
          repositories: [GitHub.Repository.minimal()],
          total_count: integer
        }

  @type pre_flight_with_repo_for_authenticated_user_200_json_resp :: %__MODULE__{
          __info__: map,
          billable_owner: GitHub.User.simple() | nil,
          defaults:
            GitHub.Codespace.Defaults.pre_flight_with_repo_for_authenticated_user_200_json_resp()
            | nil
        }

  @type repo_machines_for_authenticated_user_200_json_resp :: %__MODULE__{
          __info__: map,
          machines: [GitHub.Codespace.Machine.t()],
          total_count: integer
        }

  @type t :: %__MODULE__{
          __info__: map,
          billable_owner: GitHub.User.simple(),
          created_at: DateTime.t(),
          devcontainer_path: String.t() | nil,
          display_name: String.t() | nil,
          environment_id: String.t() | nil,
          git_status: GitHub.Codespace.GitStatus.t(),
          id: integer,
          idle_timeout_minutes: integer | nil,
          idle_timeout_notice: String.t() | nil,
          last_known_stop_notice: String.t() | nil,
          last_used_at: DateTime.t(),
          location: String.t(),
          machine: GitHub.Codespace.Machine.t() | nil,
          machines_url: String.t(),
          name: String.t(),
          owner: GitHub.User.simple(),
          pending_operation: boolean | nil,
          pending_operation_disabled_reason: String.t() | nil,
          prebuild: boolean | nil,
          publish_url: String.t() | nil,
          pulls_url: String.t() | nil,
          recent_folders: [String.t()],
          repository: GitHub.Repository.minimal(),
          retention_expires_at: DateTime.t() | nil,
          retention_period_minutes: integer | nil,
          runtime_constraints: GitHub.Codespace.RuntimeConstraints.t() | nil,
          start_url: String.t(),
          state: String.t(),
          stop_url: String.t(),
          updated_at: DateTime.t(),
          url: String.t(),
          web_url: String.t()
        }

  defstruct [
    :__info__,
    :billable_owner,
    :codespaces,
    :created_at,
    :defaults,
    :devcontainer_path,
    :devcontainers,
    :display_name,
    :environment_id,
    :git_status,
    :id,
    :idle_timeout_minutes,
    :idle_timeout_notice,
    :last_known_stop_notice,
    :last_used_at,
    :location,
    :machine,
    :machines,
    :machines_url,
    :name,
    :owner,
    :pending_operation,
    :pending_operation_disabled_reason,
    :prebuild,
    :publish_url,
    :pulls_url,
    :recent_folders,
    :repositories,
    :repository,
    :retention_expires_at,
    :retention_period_minutes,
    :runtime_constraints,
    :secrets,
    :start_url,
    :state,
    :stop_url,
    :total_count,
    :updated_at,
    :url,
    :web_url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:codespace_machines_for_authenticated_user_200_json_resp) do
    [machines: [{GitHub.Codespace.Machine, :t}], total_count: :integer]
  end

  def __fields__(:get_codespaces_for_user_in_org_200_json_resp) do
    [codespaces: [{GitHub.Codespace, :t}], total_count: :integer]
  end

  def __fields__(:list_devcontainers_in_repository_for_authenticated_user_200_json_resp) do
    [
      devcontainers: [
        {GitHub.Codespace.Devcontainers,
         :list_devcontainers_in_repository_for_authenticated_user_200_json_resp}
      ],
      total_count: :integer
    ]
  end

  def __fields__(:list_for_authenticated_user_200_json_resp) do
    [codespaces: [{GitHub.Codespace, :t}], total_count: :integer]
  end

  def __fields__(:list_in_organization_200_json_resp) do
    [codespaces: [{GitHub.Codespace, :t}], total_count: :integer]
  end

  def __fields__(:list_in_repository_for_authenticated_user_200_json_resp) do
    [codespaces: [{GitHub.Codespace, :t}], total_count: :integer]
  end

  def __fields__(:list_org_secrets_200_json_resp) do
    [secrets: [{GitHub.Codespace.OrgSecret, :t}], total_count: :integer]
  end

  def __fields__(:list_repo_secrets_200_json_resp) do
    [secrets: [{GitHub.RepoCodespacesSecret, :t}], total_count: :integer]
  end

  def __fields__(:list_repositories_for_secret_for_authenticated_user_200_json_resp) do
    [repositories: [{GitHub.Repository, :minimal}], total_count: :integer]
  end

  def __fields__(:list_secrets_for_authenticated_user_200_json_resp) do
    [secrets: [{GitHub.Codespace.Secret, :t}], total_count: :integer]
  end

  def __fields__(:list_selected_repos_for_org_secret_200_json_resp) do
    [repositories: [{GitHub.Repository, :minimal}], total_count: :integer]
  end

  def __fields__(:pre_flight_with_repo_for_authenticated_user_200_json_resp) do
    [
      billable_owner: {GitHub.User, :simple},
      defaults:
        {GitHub.Codespace.Defaults, :pre_flight_with_repo_for_authenticated_user_200_json_resp}
    ]
  end

  def __fields__(:repo_machines_for_authenticated_user_200_json_resp) do
    [machines: [{GitHub.Codespace.Machine, :t}], total_count: :integer]
  end

  def __fields__(:t) do
    [
      billable_owner: {GitHub.User, :simple},
      created_at: {:string, :date_time},
      devcontainer_path: {:union, [{:string, :generic}, :null]},
      display_name: {:union, [{:string, :generic}, :null]},
      environment_id: {:union, [{:string, :generic}, :null]},
      git_status: {GitHub.Codespace.GitStatus, :t},
      id: :integer,
      idle_timeout_minutes: {:union, [:integer, :null]},
      idle_timeout_notice: {:union, [{:string, :generic}, :null]},
      last_known_stop_notice: {:union, [{:string, :generic}, :null]},
      last_used_at: {:string, :date_time},
      location: {:enum, ["EastUs", "SouthEastAsia", "WestEurope", "WestUs2"]},
      machine: {:union, [{GitHub.Codespace.Machine, :t}, :null]},
      machines_url: {:string, :uri},
      name: {:string, :generic},
      owner: {GitHub.User, :simple},
      pending_operation: {:union, [:boolean, :null]},
      pending_operation_disabled_reason: {:union, [{:string, :generic}, :null]},
      prebuild: {:union, [:boolean, :null]},
      publish_url: {:union, [{:string, :uri}, :null]},
      pulls_url: {:union, [{:string, :uri}, :null]},
      recent_folders: [string: :generic],
      repository: {GitHub.Repository, :minimal},
      retention_expires_at: {:union, [{:string, :date_time}, :null]},
      retention_period_minutes: {:union, [:integer, :null]},
      runtime_constraints: {GitHub.Codespace.RuntimeConstraints, :t},
      start_url: {:string, :uri},
      state:
        {:enum,
         [
           "Unknown",
           "Created",
           "Queued",
           "Provisioning",
           "Available",
           "Awaiting",
           "Unavailable",
           "Deleted",
           "Moved",
           "Shutdown",
           "Archived",
           "Starting",
           "ShuttingDown",
           "Failed",
           "Exporting",
           "Updating",
           "Rebuilding"
         ]},
      stop_url: {:string, :uri},
      updated_at: {:string, :date_time},
      url: {:string, :uri},
      web_url: {:string, :uri}
    ]
  end
end
