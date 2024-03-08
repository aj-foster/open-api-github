defmodule GitHub.Accepted do
  @moduledoc """
  Provides struct and type for a Accepted
  """
  use GitHub.Encoder

  @type json_resp :: %__MODULE__{__info__: map}

  defstruct [:__info__]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:json_resp) do
    []
  end
end
