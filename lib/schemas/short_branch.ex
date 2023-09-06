defmodule GitHub.ShortBranch do
  @moduledoc """
  Provides struct and type for ShortBranch
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          commit: map,
          name: String.t(),
          protected: boolean,
          protection: GitHub.Branch.Protection.t() | nil,
          protection_url: String.t() | nil
        }

  defstruct [:__info__, :commit, :name, :protected, :protection, :protection_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      commit: :map,
      name: :string,
      protected: :boolean,
      protection: {GitHub.Branch.Protection, :t},
      protection_url: :string
    ]
  end
end
