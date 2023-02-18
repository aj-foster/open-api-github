defmodule GitHub.RequiredWorkflow do
  @moduledoc """
  Provides struct and type for RequiredWorkflow
  """

  @type t :: %__MODULE__{
          created_at: String.t(),
          id: number,
          name: String.t(),
          path: String.t(),
          ref: String.t(),
          repository: GitHub.MinimalRepository.t(),
          scope: String.t(),
          selected_repositories_url: String.t() | nil,
          state: String.t(),
          updated_at: String.t()
        }

  defstruct [
    :created_at,
    :id,
    :name,
    :path,
    :ref,
    :repository,
    :scope,
    :selected_repositories_url,
    :state,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: :string,
      id: :number,
      name: :string,
      path: :string,
      ref: :string,
      repository: {GitHub.MinimalRepository, :t},
      scope: :string,
      selected_repositories_url: :string,
      state: :string,
      updated_at: :string
    ]
  end
end
