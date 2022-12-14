defmodule GitHub.Autolink do
  @moduledoc """
  Provides struct and type for Autolink
  """

  @type t :: %__MODULE__{
          id: integer,
          is_alphanumeric: boolean,
          key_prefix: String.t(),
          url_template: String.t()
        }

  defstruct [:id, :is_alphanumeric, :key_prefix, :url_template]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, is_alphanumeric: :boolean, key_prefix: :string, url_template: :string]
  end
end
