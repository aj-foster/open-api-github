defmodule GitHub.Repository.Ruleset do
  @moduledoc """
  Provides struct and type for RepositoryRuleset
  """

  @type t :: %__MODULE__{
          _links: map | nil,
          bypass_actors: [GitHub.Repository.RulesetBypassActor.t()] | nil,
          bypass_mode: String.t() | nil,
          conditions:
            (GitHub.OrgRulesetConditions.t() | GitHub.Repository.RulesetConditions.t()) | nil,
          enforcement: String.t(),
          id: integer,
          name: String.t(),
          node_id: String.t() | nil,
          rules:
            [
              GitHub.Repository.RuleBranchNamePattern.t()
              | GitHub.Repository.RuleCommitAuthorEmailPattern.t()
              | GitHub.Repository.RuleCommitMessagePattern.t()
              | GitHub.Repository.RuleCommitterEmailPattern.t()
              | GitHub.Repository.RuleCreation.t()
              | GitHub.Repository.RuleDeletion.t()
              | GitHub.Repository.RuleNonFastForward.t()
              | GitHub.Repository.RulePullRequest.t()
              | GitHub.Repository.RuleRequiredDeployments.t()
              | GitHub.Repository.RuleRequiredLinearHistory.t()
              | GitHub.Repository.RuleRequiredSignatures.t()
              | GitHub.Repository.RuleRequiredStatusChecks.t()
              | GitHub.Repository.RuleTagNamePattern.t()
              | GitHub.Repository.RuleUpdate.t()
            ]
            | nil,
          source: String.t(),
          source_type: String.t() | nil,
          target: String.t() | nil
        }

  defstruct [
    :_links,
    :bypass_actors,
    :bypass_mode,
    :conditions,
    :enforcement,
    :id,
    :name,
    :node_id,
    :rules,
    :source,
    :source_type,
    :target
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      _links: :map,
      bypass_actors: {:array, {GitHub.Repository.RulesetBypassActor, :t}},
      bypass_mode: :string,
      conditions:
        {:union, [{GitHub.Repository.RulesetConditions, :t}, {GitHub.OrgRulesetConditions, :t}]},
      enforcement: :string,
      id: :integer,
      name: :string,
      node_id: :string,
      rules:
        {:array,
         {:union,
          [
            {GitHub.Repository.RuleCreation, :t},
            {GitHub.Repository.RuleUpdate, :t},
            {GitHub.Repository.RuleDeletion, :t},
            {GitHub.Repository.RuleRequiredLinearHistory, :t},
            {GitHub.Repository.RuleRequiredDeployments, :t},
            {GitHub.Repository.RuleRequiredSignatures, :t},
            {GitHub.Repository.RulePullRequest, :t},
            {GitHub.Repository.RuleRequiredStatusChecks, :t},
            {GitHub.Repository.RuleNonFastForward, :t},
            {GitHub.Repository.RuleCommitMessagePattern, :t},
            {GitHub.Repository.RuleCommitAuthorEmailPattern, :t},
            {GitHub.Repository.RuleCommitterEmailPattern, :t},
            {GitHub.Repository.RuleBranchNamePattern, :t},
            {GitHub.Repository.RuleTagNamePattern, :t}
          ]}},
      source: :string,
      source_type: :string,
      target: :string
    ]
  end
end
