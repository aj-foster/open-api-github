defmodule GitHub.ScopedInstallation do
  @moduledoc """
  Provides struct and type for a ScopedInstallation
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          account: GitHub.User.simple(),
          has_multiple_single_files: boolean | nil,
          permissions: GitHub.App.Permissions.t(),
          repositories_url: String.t(),
          repository_selection: String.t(),
          single_file_name: String.t() | nil,
          single_file_paths: [String.t()] | nil
        }

  defstruct [
    :__info__,
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
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      account: {GitHub.User, :simple},
      has_multiple_single_files: :boolean,
      permissions: {GitHub.App.Permissions, :t},
      repositories_url: {:string, :uri},
      repository_selection: {:enum, ["all", "selected"]},
      single_file_name: {:union, [{:string, :generic}, :null]},
      single_file_paths: [string: :generic]
    ]
  end
end
