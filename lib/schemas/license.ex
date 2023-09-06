defmodule GitHub.License do
  @moduledoc """
  Provides struct and types for License, LicenseSimple
  """
  use GitHub.Encoder

  @type simple :: %__MODULE__{
          __info__: map,
          html_url: String.t() | nil,
          key: String.t(),
          name: String.t(),
          node_id: String.t(),
          spdx_id: String.t() | nil,
          url: String.t() | nil
        }

  @type t :: %__MODULE__{
          __info__: map,
          body: String.t(),
          conditions: [String.t()],
          description: String.t(),
          featured: boolean,
          html_url: String.t(),
          implementation: String.t(),
          key: String.t(),
          limitations: [String.t()],
          name: String.t(),
          node_id: String.t(),
          permissions: [String.t()],
          spdx_id: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [
    :__info__,
    :body,
    :conditions,
    :description,
    :featured,
    :html_url,
    :implementation,
    :key,
    :limitations,
    :name,
    :node_id,
    :permissions,
    :spdx_id,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:simple) do
    [
      html_url: :string,
      key: :string,
      name: :string,
      node_id: :string,
      spdx_id: {:nullable, :string},
      url: {:nullable, :string}
    ]
  end

  def __fields__(:t) do
    [
      body: :string,
      conditions: {:array, :string},
      description: :string,
      featured: :boolean,
      html_url: :string,
      implementation: :string,
      key: :string,
      limitations: {:array, :string},
      name: :string,
      node_id: :string,
      permissions: {:array, :string},
      spdx_id: {:nullable, :string},
      url: {:nullable, :string}
    ]
  end
end
