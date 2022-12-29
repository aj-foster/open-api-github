defmodule GitHub.ServerStatistics do
  @moduledoc """
  Provides API endpoint, struct, and type related to server statistics
  """

  @default_client GitHub.Client

  @type t :: %__MODULE__{}

  defstruct []

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    []
  end

  @doc """
  Get GitHub Enterprise Server statistics

  ## Options

    * `date_start` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/overview/resources-in-the-rest-api#link-header). If specified, the query only searches for events after this cursor.
    * `date_end` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/overview/resources-in-the-rest-api#link-header). If specified, the query only searches for events before this cursor.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/enterprise-admin#get-github-enterprise-server-statistics)

  """
  @spec enterprise_admin_get_server_statistics(String.t(), keyword) ::
          {:ok, [map]} | {:error, GitHub.Error.t()}
  def enterprise_admin_get_server_statistics(enterprise_or_org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:date_end, :date_start])

    client.request(%{
      url: "/enterprise-installation/#{enterprise_or_org}/server-statistics",
      method: :get,
      query: query,
      response: [{200, {:array, :map}}],
      opts: opts
    })
  end
end
