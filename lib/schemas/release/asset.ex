defmodule GitHub.Release.Asset do
  @moduledoc """
  Provides struct and type for ReleaseAsset
  """

  @type t :: %__MODULE__{
          browser_download_url: String.t(),
          content_type: String.t(),
          created_at: String.t(),
          download_count: integer,
          id: integer,
          label: String.t() | nil,
          name: String.t(),
          node_id: String.t(),
          size: integer,
          state: String.t(),
          updated_at: String.t(),
          uploader: GitHub.User.simple() | nil,
          url: String.t()
        }

  defstruct [
    :browser_download_url,
    :content_type,
    :created_at,
    :download_count,
    :id,
    :label,
    :name,
    :node_id,
    :size,
    :state,
    :updated_at,
    :uploader,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      browser_download_url: :string,
      content_type: :string,
      created_at: :string,
      download_count: :integer,
      id: :integer,
      label: {:nullable, :string},
      name: :string,
      node_id: :string,
      size: :integer,
      state: :string,
      updated_at: :string,
      uploader: {:nullable, {GitHub.User, :simple}},
      url: :string
    ]
  end
end
