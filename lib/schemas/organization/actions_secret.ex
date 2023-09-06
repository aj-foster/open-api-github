defmodule GitHub.Organization.ActionsSecret do
  @moduledoc """
  Provides struct and type for OrganizationActionsSecret
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          created_at: String.t(),
          name: String.t(),
          selected_repositories_url: String.t() | nil,
          updated_at: String.t(),
          visibility: String.t()
        }

  defstruct [:__info__, :created_at, :name, :selected_repositories_url, :updated_at, :visibility]

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
