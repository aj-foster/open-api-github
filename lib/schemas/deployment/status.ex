defmodule GitHub.Deployment.Status do
  @moduledoc """
  Provides struct and type for DeploymentStatus
  """

  @type t :: %__MODULE__{
          created_at: String.t(),
          creator: GitHub.User.simple() | nil,
          deployment_url: String.t(),
          description: String.t(),
          environment: String.t() | nil,
          environment_url: String.t() | nil,
          id: integer,
          log_url: String.t() | nil,
          node_id: String.t(),
          performed_via_github_app: GitHub.App.t() | nil,
          repository_url: String.t(),
          state: String.t(),
          target_url: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :created_at,
    :creator,
    :deployment_url,
    :description,
    :environment,
    :environment_url,
    :id,
    :log_url,
    :node_id,
    :performed_via_github_app,
    :repository_url,
    :state,
    :target_url,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: :string,
      creator: {:nullable, {GitHub.User, :simple}},
      deployment_url: :string,
      description: :string,
      environment: :string,
      environment_url: :string,
      id: :integer,
      log_url: :string,
      node_id: :string,
      performed_via_github_app: {:nullable, {GitHub.App, :t}},
      repository_url: :string,
      state: :string,
      target_url: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
