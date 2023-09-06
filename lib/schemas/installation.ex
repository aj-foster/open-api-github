defmodule GitHub.Installation do
  @moduledoc """
  Provides struct and type for Installation
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          access_tokens_url: String.t(),
          account: (GitHub.Enterprise.t() | GitHub.User.simple()) | nil,
          app_id: integer,
          app_slug: String.t(),
          contact_email: String.t() | nil,
          created_at: String.t(),
          events: [String.t()],
          has_multiple_single_files: boolean | nil,
          html_url: String.t(),
          id: integer,
          permissions: GitHub.App.Permissions.t(),
          repositories_url: String.t(),
          repository_selection: String.t(),
          single_file_name: String.t() | nil,
          single_file_paths: [String.t()] | nil,
          suspended_at: String.t() | nil,
          suspended_by: GitHub.User.simple() | nil,
          target_id: integer,
          target_type: String.t(),
          updated_at: String.t()
        }

  defstruct [
    :__info__,
    :access_tokens_url,
    :account,
    :app_id,
    :app_slug,
    :contact_email,
    :created_at,
    :events,
    :has_multiple_single_files,
    :html_url,
    :id,
    :permissions,
    :repositories_url,
    :repository_selection,
    :single_file_name,
    :single_file_paths,
    :suspended_at,
    :suspended_by,
    :target_id,
    :target_type,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      access_tokens_url: :string,
      account: {:nullable, {:union, [{GitHub.User, :simple}, {GitHub.Enterprise, :t}]}},
      app_id: :integer,
      app_slug: :string,
      contact_email: {:nullable, :string},
      created_at: :string,
      events: {:array, :string},
      has_multiple_single_files: :boolean,
      html_url: :string,
      id: :integer,
      permissions: {GitHub.App.Permissions, :t},
      repositories_url: :string,
      repository_selection: :string,
      single_file_name: {:nullable, :string},
      single_file_paths: {:array, :string},
      suspended_at: {:nullable, :string},
      suspended_by: {:nullable, {GitHub.User, :simple}},
      target_id: :integer,
      target_type: :string,
      updated_at: :string
    ]
  end
end
