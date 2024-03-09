defmodule GitHub.Repository.CustomProperties do
  @moduledoc """
  Provides struct and type for a Repository.CustomProperties
  """
  use GitHub.Encoder

  @type full :: %__MODULE__{__info__: map}

  defstruct [:__info__]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:full) do
    []
  end
end
