defmodule GitHub.ApiOverview do
  @moduledoc """
  Provides struct and type for ApiOverview
  """

  @type t :: %__MODULE__{
          __info__: map,
          actions: [String.t()] | nil,
          api: [String.t()] | nil,
          dependabot: [String.t()] | nil,
          domains: map | nil,
          git: [String.t()] | nil,
          github_enterprise_importer: [String.t()] | nil,
          hooks: [String.t()] | nil,
          importer: [String.t()] | nil,
          packages: [String.t()] | nil,
          pages: [String.t()] | nil,
          ssh_key_fingerprints: map | nil,
          ssh_keys: [String.t()] | nil,
          verifiable_password_authentication: boolean,
          web: [String.t()] | nil
        }

  defstruct [
    :__info__,
    :actions,
    :api,
    :dependabot,
    :domains,
    :git,
    :github_enterprise_importer,
    :hooks,
    :importer,
    :packages,
    :pages,
    :ssh_key_fingerprints,
    :ssh_keys,
    :verifiable_password_authentication,
    :web
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actions: {:array, :string},
      api: {:array, :string},
      dependabot: {:array, :string},
      domains: :map,
      git: {:array, :string},
      github_enterprise_importer: {:array, :string},
      hooks: {:array, :string},
      importer: {:array, :string},
      packages: {:array, :string},
      pages: {:array, :string},
      ssh_key_fingerprints: :map,
      ssh_keys: {:array, :string},
      verifiable_password_authentication: :boolean,
      web: {:array, :string}
    ]
  end
end
