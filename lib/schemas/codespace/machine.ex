defmodule GitHub.Codespace.Machine do
  @moduledoc """
  Provides struct and type for CodespaceMachine
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          cpus: integer,
          display_name: String.t(),
          memory_in_bytes: integer,
          name: String.t(),
          operating_system: String.t(),
          prebuild_availability: String.t() | nil,
          storage_in_bytes: integer
        }

  defstruct [
    :__info__,
    :cpus,
    :display_name,
    :memory_in_bytes,
    :name,
    :operating_system,
    :prebuild_availability,
    :storage_in_bytes
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cpus: :integer,
      display_name: :string,
      memory_in_bytes: :integer,
      name: :string,
      operating_system: :string,
      prebuild_availability: {:nullable, :string},
      storage_in_bytes: :integer
    ]
  end
end
