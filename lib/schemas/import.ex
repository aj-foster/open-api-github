defmodule GitHub.Import do
  @moduledoc """
  Provides struct and type for Import
  """

  @type t :: %__MODULE__{
          authors_count: integer | nil,
          authors_url: String.t(),
          commit_count: integer | nil,
          error_message: String.t() | nil,
          failed_step: String.t() | nil,
          has_large_files: boolean | nil,
          html_url: String.t(),
          import_percent: integer | nil,
          large_files_count: integer | nil,
          large_files_size: integer | nil,
          message: String.t() | nil,
          project_choices: [map] | nil,
          push_percent: integer | nil,
          repository_url: String.t(),
          status: String.t(),
          status_text: String.t() | nil,
          svc_root: String.t() | nil,
          svn_root: String.t() | nil,
          tfvc_project: String.t() | nil,
          url: String.t(),
          use_lfs: boolean | nil,
          vcs: String.t() | nil,
          vcs_url: String.t()
        }

  defstruct [
    :authors_count,
    :authors_url,
    :commit_count,
    :error_message,
    :failed_step,
    :has_large_files,
    :html_url,
    :import_percent,
    :large_files_count,
    :large_files_size,
    :message,
    :project_choices,
    :push_percent,
    :repository_url,
    :status,
    :status_text,
    :svc_root,
    :svn_root,
    :tfvc_project,
    :url,
    :use_lfs,
    :vcs,
    :vcs_url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      authors_count: :integer,
      authors_url: :string,
      commit_count: :integer,
      error_message: :string,
      failed_step: :string,
      has_large_files: :boolean,
      html_url: :string,
      import_percent: :integer,
      large_files_count: :integer,
      large_files_size: :integer,
      message: :string,
      project_choices: {:array, :map},
      push_percent: :integer,
      repository_url: :string,
      status: :string,
      status_text: :string,
      svc_root: :string,
      svn_root: :string,
      tfvc_project: :string,
      url: :string,
      use_lfs: :boolean,
      vcs: :string,
      vcs_url: :string
    ]
  end
end
