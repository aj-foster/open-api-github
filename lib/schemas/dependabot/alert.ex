defmodule GitHub.Dependabot.Alert do
  @moduledoc """
  Provides struct and type for DependabotAlert
  """

  @type t :: %__MODULE__{
          __info__: map,
          auto_dismissed_at: String.t() | nil,
          created_at: String.t(),
          dependency: map,
          dismissed_at: String.t() | nil,
          dismissed_by: GitHub.User.simple() | nil,
          dismissed_comment: String.t() | nil,
          dismissed_reason: String.t() | nil,
          fixed_at: String.t() | nil,
          html_url: String.t(),
          number: integer,
          security_advisory: GitHub.Dependabot.Alert.SecurityAdvisory.t(),
          security_vulnerability: GitHub.Dependabot.Alert.SecurityVulnerability.t(),
          state: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :auto_dismissed_at,
    :created_at,
    :dependency,
    :dismissed_at,
    :dismissed_by,
    :dismissed_comment,
    :dismissed_reason,
    :fixed_at,
    :html_url,
    :number,
    :security_advisory,
    :security_vulnerability,
    :state,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      auto_dismissed_at: {:nullable, :string},
      created_at: :string,
      dependency: :map,
      dismissed_at: {:nullable, :string},
      dismissed_by: {:nullable, {GitHub.User, :simple}},
      dismissed_comment: {:nullable, :string},
      dismissed_reason: {:nullable, :string},
      fixed_at: {:nullable, :string},
      html_url: :string,
      number: :integer,
      security_advisory: {GitHub.Dependabot.Alert.SecurityAdvisory, :t},
      security_vulnerability: {GitHub.Dependabot.Alert.SecurityVulnerability, :t},
      state: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
