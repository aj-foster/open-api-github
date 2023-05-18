defmodule GitHub.Tag do
  @moduledoc """
  Provides struct and type for Tag
  """

  @type t :: %__MODULE__{
          __info__: map,
          commit: map,
          name: String.t(),
          node_id: String.t(),
          tarball_url: String.t(),
          zipball_url: String.t()
        }

  defstruct [:__info__, :commit, :name, :node_id, :tarball_url, :zipball_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [commit: :map, name: :string, node_id: :string, tarball_url: :string, zipball_url: :string]
  end
end
