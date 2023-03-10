defmodule GitHub.BasicError do
  @moduledoc """
  Provides struct and type for BasicError
  """

  @type t :: %__MODULE__{
          documentation_url: String.t() | nil,
          message: String.t() | nil,
          status: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [:documentation_url, :message, :status, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [documentation_url: :string, message: :string, status: :string, url: :string]
  end
end
