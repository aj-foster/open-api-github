defmodule GitHub.Installation.Token do
  @moduledoc """
  Provides struct and type for InstallationToken
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          expires_at: String.t(),
          has_multiple_single_files: boolean | nil,
          permissions: GitHub.App.Permissions.t() | nil,
          repositories: [GitHub.Repository.t()] | nil,
          repository_selection: String.t() | nil,
          single_file: String.t() | nil,
          single_file_paths: [String.t()] | nil,
          token: String.t()
        }

  defstruct [
    :__info__,
    :expires_at,
    :has_multiple_single_files,
    :permissions,
    :repositories,
    :repository_selection,
    :single_file,
    :single_file_paths,
    :token
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      expires_at: :string,
      has_multiple_single_files: :boolean,
      permissions: {GitHub.App.Permissions, :t},
      repositories: {:array, {GitHub.Repository, :t}},
      repository_selection: :string,
      single_file: :string,
      single_file_paths: {:array, :string},
      token: :string
    ]
  end
end
