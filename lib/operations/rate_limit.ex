defmodule GitHub.RateLimit do
  @moduledoc """
  Provides API endpoint, struct, and type related to rate limit
  """

  @default_client GitHub.Client

  @type t :: %__MODULE__{limit: integer, remaining: integer, reset: integer, used: integer}

  defstruct [:limit, :remaining, :reset, :used]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [limit: :integer, remaining: :integer, reset: :integer, used: :integer]
  end

  @doc """
  Get rate limit status for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/rate-limit#get-rate-limit-status-for-the-authenticated-user)

  """
  @spec get(keyword) :: {:ok, GitHub.RateLimit.Overview.t()} | {:error, GitHub.Error.t()}
  def get(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/rate_limit",
      method: :get,
      response: [
        {200, {GitHub.RateLimit.Overview, :t}},
        {304, nil},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end
end
