defmodule GitHub.Deployment do
  @moduledoc """
  Provides struct and types for Deployment, DeploymentSimple
  """
  use GitHub.Encoder

  @type simple :: %__MODULE__{
          __info__: map,
          created_at: String.t(),
          description: String.t() | nil,
          environment: String.t(),
          id: integer,
          node_id: String.t(),
          original_environment: String.t() | nil,
          performed_via_github_app: GitHub.App.t() | nil,
          production_environment: boolean | nil,
          repository_url: String.t(),
          statuses_url: String.t(),
          task: String.t(),
          transient_environment: boolean | nil,
          updated_at: String.t(),
          url: String.t()
        }

  @type t :: %__MODULE__{
          __info__: map,
          created_at: String.t(),
          creator: GitHub.User.simple() | nil,
          description: String.t() | nil,
          environment: String.t(),
          id: integer,
          node_id: String.t(),
          original_environment: String.t() | nil,
          payload: map | String.t(),
          performed_via_github_app: GitHub.App.t() | nil,
          production_environment: boolean | nil,
          ref: String.t(),
          repository_url: String.t(),
          sha: String.t(),
          statuses_url: String.t(),
          task: String.t(),
          transient_environment: boolean | nil,
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :created_at,
    :creator,
    :description,
    :environment,
    :id,
    :node_id,
    :original_environment,
    :payload,
    :performed_via_github_app,
    :production_environment,
    :ref,
    :repository_url,
    :sha,
    :statuses_url,
    :task,
    :transient_environment,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:simple) do
    [
      created_at: :string,
      description: {:nullable, :string},
      environment: :string,
      id: :integer,
      node_id: :string,
      original_environment: :string,
      performed_via_github_app: {:nullable, {GitHub.App, :t}},
      production_environment: :boolean,
      repository_url: :string,
      statuses_url: :string,
      task: :string,
      transient_environment: :boolean,
      updated_at: :string,
      url: :string
    ]
  end

  def __fields__(:t) do
    [
      created_at: :string,
      creator: {:nullable, {GitHub.User, :simple}},
      description: {:nullable, :string},
      environment: :string,
      id: :integer,
      node_id: :string,
      original_environment: :string,
      payload: {:union, [:map, :string]},
      performed_via_github_app: {:nullable, {GitHub.App, :t}},
      production_environment: :boolean,
      ref: :string,
      repository_url: :string,
      sha: :string,
      statuses_url: :string,
      task: :string,
      transient_environment: :boolean,
      updated_at: :string,
      url: :string
    ]
  end
end
