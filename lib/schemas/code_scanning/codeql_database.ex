defmodule GitHub.CodeScanning.CodeqlDatabase do
  @moduledoc """
  Provides struct and type for CodeScanningCodeqlDatabase
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          content_type: String.t(),
          created_at: String.t(),
          id: integer,
          language: String.t(),
          name: String.t(),
          size: integer,
          updated_at: String.t(),
          uploader: GitHub.User.simple(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :content_type,
    :created_at,
    :id,
    :language,
    :name,
    :size,
    :updated_at,
    :uploader,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      content_type: :string,
      created_at: :string,
      id: :integer,
      language: :string,
      name: :string,
      size: :integer,
      updated_at: :string,
      uploader: {GitHub.User, :simple},
      url: :string
    ]
  end
end
