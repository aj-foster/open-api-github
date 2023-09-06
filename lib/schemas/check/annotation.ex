defmodule GitHub.Check.Annotation do
  @moduledoc """
  Provides struct and type for CheckAnnotation
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          annotation_level: String.t() | nil,
          blob_href: String.t(),
          end_column: integer | nil,
          end_line: integer,
          message: String.t() | nil,
          path: String.t(),
          raw_details: String.t() | nil,
          start_column: integer | nil,
          start_line: integer,
          title: String.t() | nil
        }

  defstruct [
    :__info__,
    :annotation_level,
    :blob_href,
    :end_column,
    :end_line,
    :message,
    :path,
    :raw_details,
    :start_column,
    :start_line,
    :title
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      annotation_level: {:nullable, :string},
      blob_href: :string,
      end_column: {:nullable, :integer},
      end_line: :integer,
      message: {:nullable, :string},
      path: :string,
      raw_details: {:nullable, :string},
      start_column: {:nullable, :integer},
      start_line: :integer,
      title: {:nullable, :string}
    ]
  end
end
