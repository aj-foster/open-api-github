defmodule GitHub.Markdown do
  @moduledoc """
  Provides API endpoints related to markdown
  """

  @default_client GitHub.Client

  @doc """
  Render a Markdown document

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/markdown#render-a-markdown-document)

  """
  @spec render(map, keyword) :: {:ok, String.t()} | :error
  def render(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/markdown",
      body: body,
      method: :post,
      response: [{200, :string}, {304, nil}],
      opts: opts
    })
  end

  @doc """
  Render a Markdown document in raw mode

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/markdown#render-a-markdown-document-in-raw-mode)

  """
  @spec render_raw(map, keyword) :: {:ok, String.t()} | :error
  def render_raw(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/markdown/raw",
      body: body,
      method: :post,
      response: [{200, :string}, {304, nil}],
      opts: opts
    })
  end
end
