defmodule GitHub.Gitignore do
  @moduledoc """
  Provides API endpoints related to gitignore
  """

  @default_client GitHub.Client

  @doc """
  Get all gitignore templates

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gitignore#get-all-gitignore-templates)

  """
  @spec get_all_templates(keyword) :: {:ok, [String.t()]} | {:error, GitHub.Error.t()}
  def get_all_templates(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/gitignore/templates",
      method: :get,
      response: [{200, {:array, :string}}, {304, nil}],
      opts: opts
    })
  end

  @doc """
  Get a gitignore template

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gitignore#get-a-gitignore-template)

  """
  @spec get_template(String.t(), keyword) ::
          {:ok, :"Elixir.GitHub.Git.ignoreTemplate".t()} | {:error, GitHub.Error.t()}
  def get_template(name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/gitignore/templates/#{name}",
      method: :get,
      response: [{200, {:"Elixir.GitHub.Git.ignoreTemplate", :t}}, {304, nil}],
      opts: opts
    })
  end
end
