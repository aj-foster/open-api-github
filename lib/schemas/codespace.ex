defmodule GitHub.Codespace do
  @moduledoc """
  Provides struct and type for Codespace
  """

  @type t :: %__MODULE__{
          billable_owner: GitHub.User.simple(),
          created_at: String.t(),
          devcontainer_path: String.t() | nil,
          display_name: String.t() | nil,
          environment_id: String.t() | nil,
          git_status: map,
          id: integer,
          idle_timeout_minutes: integer | nil,
          idle_timeout_notice: String.t() | nil,
          last_known_stop_notice: String.t() | nil,
          last_used_at: String.t(),
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
          repository: GitHub.MinimalRepository.t(),
          retention_expires_at: String.t() | nil,
          retention_period_minutes: integer | nil,
          runtime_constraints: map | nil,
          start_url: String.t(),
          state: String.t(),
          stop_url: String.t(),
          updated_at: String.t(),
          url: String.t(),
          web_url: String.t()
        }

  defstruct [
    :billable_owner,
    :created_at,
    :devcontainer_path,
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
    :machines_url,
    :name,
    :owner,
    :pending_operation,
    :pending_operation_disabled_reason,
    :prebuild,
    :publish_url,
    :pulls_url,
    :recent_folders,
    :repository,
    :retention_expires_at,
    :retention_period_minutes,
    :runtime_constraints,
    :start_url,
    :state,
    :stop_url,
    :updated_at,
    :url,
    :web_url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      billable_owner: {GitHub.User, :simple},
      created_at: :string,
      devcontainer_path: {:nullable, :string},
      display_name: {:nullable, :string},
      environment_id: {:nullable, :string},
      git_status: :map,
      id: :integer,
      idle_timeout_minutes: {:nullable, :integer},
      idle_timeout_notice: {:nullable, :string},
      last_known_stop_notice: {:nullable, :string},
      last_used_at: :string,
      location: :string,
      machine: {:nullable, {GitHub.Codespace.Machine, :t}},
      machines_url: :string,
      name: :string,
      owner: {GitHub.User, :simple},
      pending_operation: {:nullable, :boolean},
      pending_operation_disabled_reason: {:nullable, :string},
      prebuild: {:nullable, :boolean},
      publish_url: {:nullable, :string},
      pulls_url: {:nullable, :string},
      recent_folders: {:array, :string},
      repository: {GitHub.MinimalRepository, :t},
      retention_expires_at: {:nullable, :string},
      retention_period_minutes: {:nullable, :integer},
      runtime_constraints: :map,
      start_url: :string,
      state: :string,
      stop_url: :string,
      updated_at: :string,
      url: :string,
      web_url: :string
    ]
  end
end
