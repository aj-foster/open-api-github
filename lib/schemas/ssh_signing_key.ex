defmodule GitHub.SSHSigningKey do
  @moduledoc """
  Provides struct and type for SshSigningKey
  """

  @type t :: %__MODULE__{created_at: String.t(), id: integer, key: String.t(), title: String.t()}

  defstruct [:created_at, :id, :key, :title]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [created_at: :string, id: :integer, key: :string, title: :string]
  end
end
