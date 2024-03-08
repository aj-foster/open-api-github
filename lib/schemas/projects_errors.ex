defmodule GitHub.ProjectsErrors do
  @moduledoc """
  Provides struct and types for a ProjectsErrors
  """
  use GitHub.Encoder

  @type create_card_503_json_resp :: %__MODULE__{
          __info__: map,
          code: String.t() | nil,
          message: String.t() | nil
        }

  @type move_card_403_json_resp :: %__MODULE__{
          __info__: map,
          code: String.t() | nil,
          field: String.t() | nil,
          message: String.t() | nil,
          resource: String.t() | nil
        }

  @type move_card_503_json_resp :: %__MODULE__{
          __info__: map,
          code: String.t() | nil,
          message: String.t() | nil
        }

  defstruct [:__info__, :code, :field, :message, :resource]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:create_card_503_json_resp) do
    [code: {:string, :generic}, message: {:string, :generic}]
  end

  def __fields__(:move_card_403_json_resp) do
    [
      code: {:string, :generic},
      field: {:string, :generic},
      message: {:string, :generic},
      resource: {:string, :generic}
    ]
  end

  def __fields__(:move_card_503_json_resp) do
    [code: {:string, :generic}, message: {:string, :generic}]
  end
end
