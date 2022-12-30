defmodule GitHub.Pages.Deployment do
  @moduledoc """
  Provides struct and type for PageDeployment
  """

  @type t :: %__MODULE__{
          page_url: String.t(),
          preview_url: String.t() | nil,
          status_url: String.t()
        }

  defstruct [:page_url, :preview_url, :status_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [page_url: :string, preview_url: :string, status_url: :string]
  end
end
