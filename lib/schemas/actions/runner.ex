defmodule GitHub.Actions.Runner do
  @moduledoc """
  Provides struct and type for Runner
  """

  @type t :: %__MODULE__{
          busy: boolean,
          id: integer,
          labels: [GitHub.Actions.Runner.Label.t()],
          name: String.t(),
          os: String.t(),
          status: String.t()
        }

  defstruct [:busy, :id, :labels, :name, :os, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      busy: :boolean,
      id: :integer,
      labels: {:array, {GitHub.Actions.Runner.Label, :t}},
      name: :string,
      os: :string,
      status: :string
    ]
  end
end
