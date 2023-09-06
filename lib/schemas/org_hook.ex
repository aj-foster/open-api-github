defmodule GitHub.OrgHook do
  @moduledoc """
  Provides struct and type for OrgHook
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          active: boolean,
          config: map,
          created_at: String.t(),
          deliveries_url: String.t() | nil,
          events: [String.t()],
          id: integer,
          name: String.t(),
          ping_url: String.t(),
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
    :name,
    :ping_url,
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
      name: :string,
      ping_url: :string,
      type: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
