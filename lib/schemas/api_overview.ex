defmodule GitHub.ApiOverview do
  @moduledoc """
  Provides struct and type for a ApiOverview
  """
  use GitHub.Encoder

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
      actions: [string: :generic],
      api: [string: :generic],
      dependabot: [string: :generic],
      domains: :map,
      git: [string: :generic],
      github_enterprise_importer: [string: :generic],
      hooks: [string: :generic],
      importer: [string: :generic],
      packages: [string: :generic],
      pages: [string: :generic],
      ssh_key_fingerprints: :map,
      ssh_keys: [string: :generic],
      verifiable_password_authentication: :boolean,
      web: [string: :generic]
    ]
  end
end
