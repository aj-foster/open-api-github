defmodule GitHub.License do
  @moduledoc """
  Provides struct and types for a License
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

  defstruct [:__info__, :html_url, :key, :name, :node_id, :spdx_id, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:simple) do
    [
      html_url: {:string, :uri},
      key: {:string, :generic},
      name: {:string, :generic},
      node_id: {:string, :generic},
      spdx_id: {:union, [{:string, :generic}, :null]},
      url: {:union, [{:string, :uri}, :null]}
    ]
  end
end
