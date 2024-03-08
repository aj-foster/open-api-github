defmodule GitHub.Codespace.Defaults do
  @moduledoc """
  Provides struct and type for a Codespace.Defaults
  """
  use GitHub.Encoder

  @type pre_flight_with_repo_for_authenticated_user_200_json_resp :: %__MODULE__{
          __info__: map,
          devcontainer_path: String.t() | nil,
          location: String.t()
        }

  defstruct [:__info__, :devcontainer_path, :location]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:pre_flight_with_repo_for_authenticated_user_200_json_resp) do
    [devcontainer_path: {:union, [{:string, :generic}, :null]}, location: {:string, :generic}]
  end
end
