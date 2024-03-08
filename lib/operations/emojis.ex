defmodule GitHub.Emojis do
  @moduledoc """
  Provides API endpoint related to emojis
  """

  @default_client GitHub.Client

  @type get_200_json_resp :: %__MODULE__{__info__: map}

  defstruct [:__info__]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:get_200_json_resp) do
    []
  end

  @doc """
  Get emojis

  Lists all the emojis available to use on GitHub.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/emojis/emojis#get-emojis)

  """
  @spec get(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def get(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {GitHub.Emojis, :get},
      url: "/emojis",
      method: :get,
      response: [{200, :map}, {304, :null}],
      opts: opts
    })
  end
end
