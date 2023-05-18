defmodule GitHub.ProtectedBranch.RequiredStatusCheck do
  @moduledoc """
  Provides struct and type for ProtectedBranchRequiredStatusCheck
  """

  @type t :: %__MODULE__{
          __info__: map,
          checks: [map],
          contexts: [String.t()],
          contexts_url: String.t() | nil,
          enforcement_level: String.t() | nil,
          strict: boolean | nil,
          url: String.t() | nil
        }

  defstruct [:__info__, :checks, :contexts, :contexts_url, :enforcement_level, :strict, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      checks: {:array, :map},
      contexts: {:array, :string},
      contexts_url: :string,
      enforcement_level: :string,
      strict: :boolean,
      url: :string
    ]
  end
end
