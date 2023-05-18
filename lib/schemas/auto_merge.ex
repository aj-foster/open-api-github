defmodule GitHub.AutoMerge do
  @moduledoc """
  Provides struct and type for AutoMerge
  """

  @type t :: %__MODULE__{
          __info__: map,
          commit_message: String.t(),
          commit_title: String.t(),
          enabled_by: GitHub.User.simple(),
          merge_method: String.t()
        }

  defstruct [:__info__, :commit_message, :commit_title, :enabled_by, :merge_method]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      commit_message: :string,
      commit_title: :string,
      enabled_by: {GitHub.User, :simple},
      merge_method: :string
    ]
  end
end
