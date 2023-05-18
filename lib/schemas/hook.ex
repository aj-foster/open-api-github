defmodule GitHub.Hook do
  @moduledoc """
  Provides struct and type for Hook
  """

  @type t :: %__MODULE__{
          __info__: map,
          active: boolean,
          config: map,
          created_at: String.t(),
          deliveries_url: String.t() | nil,
          events: [String.t()],
          id: integer,
          last_response: GitHub.Hook.Response.t(),
          name: String.t(),
          ping_url: String.t(),
          test_url: String.t(),
          type: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :active,
    :config,
    :created_at,
    :deliveries_url,
    :events,
    :id,
    :last_response,
    :name,
    :ping_url,
    :test_url,
    :type,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      active: :boolean,
      config: :map,
      created_at: :string,
      deliveries_url: :string,
      events: {:array, :string},
      id: :integer,
      last_response: {GitHub.Hook.Response, :t},
      name: :string,
      ping_url: :string,
      test_url: :string,
      type: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
