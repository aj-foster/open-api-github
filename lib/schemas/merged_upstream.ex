defmodule GitHub.MergedUpstream do
  @moduledoc """
  Provides struct and type for MergedUpstream
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          base_branch: String.t() | nil,
          merge_type: String.t() | nil,
          message: String.t() | nil
        }

  defstruct [:__info__, :base_branch, :merge_type, :message]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [base_branch: :string, merge_type: :string, message: :string]
  end
end
