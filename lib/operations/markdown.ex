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
  @spec render(map, keyword) :: {:ok, binary} | {:error, GitHub.Error.t()}
  def render(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {GitHub.Markdown, :render},
      url: "/markdown",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :binary}, {304, nil}],
      opts: opts
    })
  end

  @doc """
  Render a Markdown document in raw mode

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/markdown#render-a-markdown-document-in-raw-mode)

  """
  @spec render_raw(String.t(), keyword) :: {:ok, binary} | {:error, GitHub.Error.t()}
  def render_raw(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {GitHub.Markdown, :render_raw},
      url: "/markdown/raw",
      body: body,
      method: :post,
      request: [{"text/plain", :string}, {"text/x-markdown", :string}],
      response: [{200, :binary}, {304, nil}],
      opts: opts
    })
  end
end
