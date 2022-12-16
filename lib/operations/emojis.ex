defmodule GitHub.Emojis do
  @moduledoc """
  Provides API endpoint related to emojis
  """

  @default_client GitHub.Client

  @doc """
  Get emojis

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/emojis#get-emojis)

  """
  @spec get(keyword) :: {:ok, map} | :error
  def get(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/emojis",
      method: :get,
      response: [{200, :map}, {304, nil}],
      opts: opts
    })
  end
end
