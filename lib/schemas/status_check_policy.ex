defmodule GitHub.StatusCheckPolicy do
  @moduledoc """
  Provides struct and type for StatusCheckPolicy
  """

  @type t :: %__MODULE__{
          checks: [map],
          contexts: [String.t()],
          contexts_url: String.t(),
          strict: boolean,
          url: String.t()
        }

  defstruct [:checks, :contexts, :contexts_url, :strict, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      checks: {:array, :map},
      contexts: {:array, :string},
      contexts_url: :string,
      strict: :boolean,
      url: :string
    ]
  end
end
