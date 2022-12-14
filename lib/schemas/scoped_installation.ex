defmodule GitHub.ScopedInstallation do
  @moduledoc """
  Provides struct and type for NullableScopedInstallation
  """

  @type nullable :: %__MODULE__{
          account: GitHub.User.simple(),
          has_multiple_single_files: boolean | nil,
          permissions: GitHub.AppPermissions.t(),
          repositories_url: String.t(),
          repository_selection: String.t(),
          single_file_name: String.t() | nil,
          single_file_paths: [String.t()] | nil
        }

  defstruct [
    :account,
    :has_multiple_single_files,
    :permissions,
    :repositories_url,
    :repository_selection,
    :single_file_name,
    :single_file_paths
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:nullable) do
    [
      account: {GitHub.User, :simple},
      has_multiple_single_files: :boolean,
      permissions: {GitHub.AppPermissions, :t},
      repositories_url: :string,
      repository_selection: :string,
      single_file_name: :string,
      single_file_paths: {:array, :string}
    ]
  end
end
