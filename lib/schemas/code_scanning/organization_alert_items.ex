defmodule GitHub.CodeScanning.OrganizationAlertItems do
  @moduledoc """
  Provides struct and type for CodeScanningOrganizationAlertItems
  """

  @type t :: %__MODULE__{
          created_at: String.t(),
          dismissed_at: String.t() | nil,
          dismissed_by: GitHub.User.simple() | nil,
          dismissed_comment: String.t() | nil,
          dismissed_reason: String.t() | nil,
          fixed_at: String.t() | nil,
          html_url: String.t(),
          instances_url: String.t(),
          most_recent_instance: GitHub.CodeScanning.AlertInstance.t(),
          number: integer,
          repository: GitHub.Repository.simple(),
          rule: GitHub.CodeScanning.AlertRule.t(),
          state: String.t(),
          tool: GitHub.CodeScanning.AnalysisTool.t(),
          updated_at: String.t() | nil,
          url: String.t()
        }

  defstruct [
    :created_at,
    :dismissed_at,
    :dismissed_by,
    :dismissed_comment,
    :dismissed_reason,
    :fixed_at,
    :html_url,
    :instances_url,
    :most_recent_instance,
    :number,
    :repository,
    :rule,
    :state,
    :tool,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: :string,
      dismissed_at: {:nullable, :string},
      dismissed_by: {:nullable, {GitHub.User, :simple}},
      dismissed_comment: {:nullable, :string},
      dismissed_reason: {:nullable, :string},
      fixed_at: {:nullable, :string},
      html_url: :string,
      instances_url: :string,
      most_recent_instance: {GitHub.CodeScanning.AlertInstance, :t},
      number: :integer,
      repository: {GitHub.Repository, :simple},
      rule: {GitHub.CodeScanning.AlertRule, :t},
      state: :string,
      tool: {GitHub.CodeScanning.AnalysisTool, :t},
      updated_at: :string,
      url: :string
    ]
  end
end
