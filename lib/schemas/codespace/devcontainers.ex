defmodule GitHub.Codespace.Devcontainers do
  @moduledoc """
  Provides struct and type for a Codespace.Devcontainers
  """
  use GitHub.Encoder

  @type list_devcontainers_in_repository_for_authenticated_user_200_json_resp :: %__MODULE__{
          __info__: map,
          display_name: String.t() | nil,
          name: String.t() | nil,
          path: String.t()
        }

  defstruct [:__info__, :display_name, :name, :path]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:list_devcontainers_in_repository_for_authenticated_user_200_json_resp) do
    [display_name: {:string, :generic}, name: {:string, :generic}, path: {:string, :generic}]
  end
end
