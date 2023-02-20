defmodule GitHub.CodesOfConduct do
  @moduledoc """
  Provides API endpoints related to codes of conduct
  """

  @default_client GitHub.Client

  @doc """
  Get all codes of conduct

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codes-of-conduct#get-all-codes-of-conduct)

  """
  @spec get_all_codes_of_conduct(keyword) ::
          {:ok, [GitHub.CodeOfConduct.t()]} | {:error, GitHub.Error.t()}
  def get_all_codes_of_conduct(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/codes_of_conduct",
      method: :get,
      response: [{200, {:array, {GitHub.CodeOfConduct, :t}}}, {304, nil}],
      opts: opts
    })
  end

  @doc """
  Get a code of conduct

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codes-of-conduct#get-a-code-of-conduct)

  """
  @spec get_conduct_code(String.t(), keyword) ::
          {:ok, GitHub.CodeOfConduct.t()} | {:error, GitHub.Error.t()}
  def get_conduct_code(key, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [key: key],
      url: "/codes_of_conduct/#{key}",
      method: :get,
      response: [{200, {GitHub.CodeOfConduct, :t}}, {304, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end
end
