defmodule GitHub.Organization.SecretScanningAlert do
  @moduledoc """
  Provides struct and type for OrganizationSecretScanningAlert
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          created_at: String.t() | nil,
          html_url: String.t() | nil,
          locations_url: String.t() | nil,
          number: integer | nil,
          push_protection_bypassed: boolean | nil,
          push_protection_bypassed_at: String.t() | nil,
          push_protection_bypassed_by: GitHub.User.simple() | nil,
          repository: GitHub.Repository.simple() | nil,
          resolution: String.t() | nil,
          resolution_comment: String.t() | nil,
          resolved_at: String.t() | nil,
          resolved_by: GitHub.User.simple() | nil,
          secret: String.t() | nil,
          secret_type: String.t() | nil,
          secret_type_display_name: String.t() | nil,
          state: String.t() | nil,
          updated_at: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [
    :__info__,
    :created_at,
    :html_url,
    :locations_url,
    :number,
    :push_protection_bypassed,
    :push_protection_bypassed_at,
    :push_protection_bypassed_by,
    :repository,
    :resolution,
    :resolution_comment,
    :resolved_at,
    :resolved_by,
    :secret,
    :secret_type,
    :secret_type_display_name,
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
      html_url: :string,
      locations_url: :string,
      number: :integer,
      push_protection_bypassed: {:nullable, :boolean},
      push_protection_bypassed_at: {:nullable, :string},
      push_protection_bypassed_by: {:nullable, {GitHub.User, :simple}},
      repository: {GitHub.Repository, :simple},
      resolution: {:nullable, :string},
      resolution_comment: {:nullable, :string},
      resolved_at: {:nullable, :string},
      resolved_by: {:nullable, {GitHub.User, :simple}},
      secret: :string,
      secret_type: :string,
      secret_type_display_name: :string,
      state: :string,
      updated_at: {:nullable, :string},
      url: :string
    ]
  end
end
