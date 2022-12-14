defmodule GitHub.Dependabot.Alert.WithRepository do
  @moduledoc """
  Provides struct and type for DependabotAlertWithRepository
  """

  @type t :: %__MODULE__{
          created_at: String.t(),
          dependency: map,
          dismissed_at: String.t() | nil,
          dismissed_by: GitHub.User.simple() | nil,
          dismissed_comment: String.t() | nil,
          dismissed_reason: String.t() | nil,
          fixed_at: String.t() | nil,
          html_url: String.t(),
          number: integer,
          repository: GitHub.Repository.simple(),
          security_advisory: GitHub.Dependabot.Alert.SecurityAdvisory.t(),
          security_vulnerability: GitHub.Dependabot.Alert.SecurityVulnerability.t(),
          state: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :created_at,
    :dependency,
    :dismissed_at,
    :dismissed_by,
    :dismissed_comment,
    :dismissed_reason,
    :fixed_at,
    :html_url,
    :number,
    :repository,
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
      created_at: :string,
      dependency: :map,
      dismissed_at: :string,
      dismissed_by: {GitHub.User, :simple},
      dismissed_comment: :string,
      dismissed_reason: :string,
      fixed_at: :string,
      html_url: :string,
      number: :integer,
      repository: {GitHub.Repository, :simple},
      security_advisory: {GitHub.Dependabot.Alert.SecurityAdvisory, :t},
      security_vulnerability: {GitHub.Dependabot.Alert.SecurityVulnerability, :t},
      state: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
