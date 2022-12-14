defmodule GitHub.SCIM.Error do
  @moduledoc """
  Provides struct and type for ScimError
  """

  @type t :: %__MODULE__{
          detail: String.t() | nil,
          documentation_url: String.t() | nil,
          message: String.t() | nil,
          schemas: [String.t()] | nil,
          scimType: String.t() | nil,
          status: integer | nil
        }

  defstruct [:detail, :documentation_url, :message, :schemas, :scimType, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      detail: :string,
      documentation_url: :string,
      message: :string,
      schemas: {:array, :string},
      scimType: :string,
      status: :integer
    ]
  end
end
