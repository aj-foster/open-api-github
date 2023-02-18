defmodule GitHub.CodeOfConduct do
  @moduledoc """
  Provides struct and types for CodeOfConduct, CodeOfConductSimple
  """

  @type simple :: %__MODULE__{
          html_url: String.t() | nil,
          key: String.t(),
          name: String.t(),
          url: String.t()
        }

  @type t :: %__MODULE__{
          body: String.t() | nil,
          html_url: String.t() | nil,
          key: String.t(),
          name: String.t(),
          url: String.t()
        }

  defstruct [:body, :html_url, :key, :name, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:simple) do
    [html_url: {:nullable, :string}, key: :string, name: :string, url: :string]
  end

  def __fields__(:t) do
    [body: :string, html_url: {:nullable, :string}, key: :string, name: :string, url: :string]
  end
end
