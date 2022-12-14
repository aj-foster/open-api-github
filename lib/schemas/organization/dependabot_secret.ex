defmodule GitHub.Organization.DependabotSecret do
  @moduledoc """
  Provides struct and type for OrganizationDependabotSecret
  """

  @type t :: %__MODULE__{
          created_at: String.t(),
          name: String.t(),
          selected_repositories_url: String.t() | nil,
          updated_at: String.t(),
          visibility: String.t()
        }

  defstruct [:created_at, :name, :selected_repositories_url, :updated_at, :visibility]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: :string,
      name: :string,
      selected_repositories_url: :string,
      updated_at: :string,
      visibility: :string
    ]
  end
end
