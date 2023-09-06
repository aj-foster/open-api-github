defmodule GitHub.Pages.HttpsCertificate do
  @moduledoc """
  Provides struct and type for PagesHttpsCertificate
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          description: String.t(),
          domains: [String.t()],
          expires_at: String.t() | nil,
          state: String.t()
        }

  defstruct [:__info__, :description, :domains, :expires_at, :state]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [description: :string, domains: {:array, :string}, expires_at: :string, state: :string]
  end
end
