defmodule GitHub.PackageVersion do
  @moduledoc """
  Provides struct and type for PackageVersion
  """

  @type t :: %__MODULE__{
          created_at: String.t(),
          deleted_at: String.t() | nil,
          description: String.t() | nil,
          html_url: String.t() | nil,
          id: integer,
          license: String.t() | nil,
          metadata: map | nil,
          name: String.t(),
          package_html_url: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :created_at,
    :deleted_at,
    :description,
    :html_url,
    :id,
    :license,
    :metadata,
    :name,
    :package_html_url,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: :string,
      deleted_at: :string,
      description: :string,
      html_url: :string,
      id: :integer,
      license: :string,
      metadata: :map,
      name: :string,
      package_html_url: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
