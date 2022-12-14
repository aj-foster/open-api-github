defmodule GitHub.TagProtection do
  @moduledoc """
  Provides struct and type for TagProtection
  """

  @type t :: %__MODULE__{
          created_at: String.t() | nil,
          enabled: boolean | nil,
          id: integer | nil,
          pattern: String.t(),
          updated_at: String.t() | nil
        }

  defstruct [:created_at, :enabled, :id, :pattern, :updated_at]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [created_at: :string, enabled: :boolean, id: :integer, pattern: :string, updated_at: :string]
  end
end
