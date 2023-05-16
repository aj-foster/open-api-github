defmodule GitHub.ReviewCustomGatesStateRequired do
  @moduledoc """
  Provides struct and type for ReviewCustomGatesStateRequired
  """

  @type t :: %__MODULE__{
          comment: String.t() | nil,
          environment_name: String.t(),
          state: String.t()
        }

  defstruct [:comment, :environment_name, :state]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [comment: :string, environment_name: :string, state: :string]
  end
end
