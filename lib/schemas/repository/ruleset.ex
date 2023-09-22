defmodule GitHub.Repository.Ruleset do
  @moduledoc """
  Provides struct and type for a Repository.Ruleset
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          _links: map | nil,
          bypass_actors: [GitHub.Repository.Ruleset.BypassActor.t()] | nil,
          conditions: map | GitHub.Repository.Ruleset.Conditions.t() | nil,
          created_at: DateTime.t() | nil,
          current_user_can_bypass: String.t() | nil,
          enforcement: String.t(),
          id: integer,
          name: String.t(),
          node_id: String.t() | nil,
          rules: [map] | nil,
          source: String.t(),
          source_type: String.t() | nil,
          target: String.t() | nil,
          updated_at: DateTime.t() | nil
        }

  defstruct [
    :__info__,
    :_links,
    :bypass_actors,
    :conditions,
    :created_at,
    :current_user_can_bypass,
    :enforcement,
    :id,
    :name,
    :node_id,
    :rules,
    :source,
    :source_type,
    :target,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      _links: :map,
      bypass_actors: [{GitHub.Repository.Ruleset.BypassActor, :t}],
      conditions: {:union, [:map, {GitHub.Repository.Ruleset.Conditions, :t}]},
      created_at: {:string, :date_time},
      current_user_can_bypass: {:enum, ["always", "pull_requests_only", "never"]},
      enforcement: {:enum, ["disabled", "active", "evaluate"]},
      id: :integer,
      name: {:string, :generic},
      node_id: {:string, :generic},
      rules: [:map],
      source: {:string, :generic},
      source_type: {:enum, ["Repository", "Organization"]},
      target: {:enum, ["branch", "tag"]},
      updated_at: {:string, :date_time}
    ]
  end
end
