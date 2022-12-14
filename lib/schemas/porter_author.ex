defmodule GitHub.PorterAuthor do
  @moduledoc """
  Provides struct and type for PorterAuthor
  """

  @type t :: %__MODULE__{
          email: String.t(),
          id: integer,
          import_url: String.t(),
          name: String.t(),
          remote_id: String.t(),
          remote_name: String.t(),
          url: String.t()
        }

  defstruct [:email, :id, :import_url, :name, :remote_id, :remote_name, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      email: :string,
      id: :integer,
      import_url: :string,
      name: :string,
      remote_id: :string,
      remote_name: :string,
      url: :string
    ]
  end
end
