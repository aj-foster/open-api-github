defmodule GitHub.SelectedActions do
  @moduledoc """
  Provides struct and type for SelectedActions
  """

  @type t :: %__MODULE__{
          github_owned_allowed: boolean | nil,
          patterns_allowed: [String.t()] | nil,
          verified_allowed: boolean | nil
        }

  defstruct [:github_owned_allowed, :patterns_allowed, :verified_allowed]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      github_owned_allowed: :boolean,
      patterns_allowed: {:array, :string},
      verified_allowed: :boolean
    ]
  end
end
