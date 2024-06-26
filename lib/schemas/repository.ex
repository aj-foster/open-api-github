defmodule GitHub.Repository do
  @moduledoc """
  Provides struct and types for a Repository
  """
  use GitHub.Encoder

  @type full :: %__MODULE__{
          __info__: map,
          allow_auto_merge: boolean | nil,
          allow_forking: boolean | nil,
          allow_merge_commit: boolean | nil,
          allow_rebase_merge: boolean | nil,
          allow_squash_merge: boolean | nil,
          allow_update_branch: boolean | nil,
          anonymous_access_enabled: boolean | nil,
          archive_url: String.t(),
          archived: boolean,
          assignees_url: String.t(),
          blobs_url: String.t(),
          branches_url: String.t(),
          clone_url: String.t(),
          code_of_conduct: GitHub.CodeOfConduct.simple() | nil,
          collaborators_url: String.t(),
          comments_url: String.t(),
          commits_url: String.t(),
          compare_url: String.t(),
          contents_url: String.t(),
          contributors_url: String.t(),
          created_at: DateTime.t(),
          custom_properties: map | nil,
          default_branch: String.t(),
          delete_branch_on_merge: boolean | nil,
          deployments_url: String.t(),
          description: String.t() | nil,
          disabled: boolean,
          downloads_url: String.t(),
          events_url: String.t(),
          fork: boolean,
          forks: integer,
          forks_count: integer,
          forks_url: String.t(),
          full_name: String.t(),
          git_commits_url: String.t(),
          git_refs_url: String.t(),
          git_tags_url: String.t(),
          git_url: String.t(),
          has_discussions: boolean,
          has_downloads: boolean | nil,
          has_issues: boolean,
          has_pages: boolean,
          has_projects: boolean,
          has_wiki: boolean,
          homepage: String.t() | nil,
          hooks_url: String.t(),
          html_url: String.t(),
          id: integer,
          is_template: boolean | nil,
          issue_comment_url: String.t(),
          issue_events_url: String.t(),
          issues_url: String.t(),
          keys_url: String.t(),
          labels_url: String.t(),
          language: String.t() | nil,
          languages_url: String.t(),
          license: GitHub.License.simple() | nil,
          master_branch: String.t() | nil,
          merge_commit_message: String.t() | nil,
          merge_commit_title: String.t() | nil,
          merges_url: String.t(),
          milestones_url: String.t(),
          mirror_url: String.t() | nil,
          name: String.t(),
          network_count: integer,
          node_id: String.t(),
          notifications_url: String.t(),
          open_issues: integer,
          open_issues_count: integer,
          organization: GitHub.User.simple() | nil,
          owner: GitHub.User.simple(),
          parent: GitHub.Repository.t() | nil,
          permissions: GitHub.Repository.Permissions.full() | nil,
          private: boolean,
          pulls_url: String.t(),
          pushed_at: DateTime.t(),
          releases_url: String.t(),
          security_and_analysis: GitHub.SecurityAndAnalysis.t() | nil,
          size: integer,
          source: GitHub.Repository.t() | nil,
          squash_merge_commit_message: String.t() | nil,
          squash_merge_commit_title: String.t() | nil,
          ssh_url: String.t(),
          stargazers_count: integer,
          stargazers_url: String.t(),
          statuses_url: String.t(),
          subscribers_count: integer,
          subscribers_url: String.t(),
          subscription_url: String.t(),
          svn_url: String.t(),
          tags_url: String.t(),
          teams_url: String.t(),
          temp_clone_token: String.t() | nil,
          template_repository: GitHub.Repository.t() | nil,
          topics: [String.t()] | nil,
          trees_url: String.t(),
          updated_at: DateTime.t(),
          url: String.t(),
          use_squash_pr_title_as_default: boolean | nil,
          visibility: String.t() | nil,
          watchers: integer,
          watchers_count: integer,
          web_commit_signoff_required: boolean | nil
        }

  @type minimal :: %__MODULE__{
          __info__: map,
          allow_forking: boolean | nil,
          archive_url: String.t(),
          archived: boolean | nil,
          assignees_url: String.t(),
          blobs_url: String.t(),
          branches_url: String.t(),
          clone_url: String.t() | nil,
          code_of_conduct: GitHub.CodeOfConduct.t() | nil,
          collaborators_url: String.t(),
          comments_url: String.t(),
          commits_url: String.t(),
          compare_url: String.t(),
          contents_url: String.t(),
          contributors_url: String.t(),
          created_at: DateTime.t() | nil,
          default_branch: String.t() | nil,
          delete_branch_on_merge: boolean | nil,
          deployments_url: String.t(),
          description: String.t() | nil,
          disabled: boolean | nil,
          downloads_url: String.t(),
          events_url: String.t(),
          fork: boolean,
          forks: integer | nil,
          forks_count: integer | nil,
          forks_url: String.t(),
          full_name: String.t(),
          git_commits_url: String.t(),
          git_refs_url: String.t(),
          git_tags_url: String.t(),
          git_url: String.t() | nil,
          has_discussions: boolean | nil,
          has_downloads: boolean | nil,
          has_issues: boolean | nil,
          has_pages: boolean | nil,
          has_projects: boolean | nil,
          has_wiki: boolean | nil,
          homepage: String.t() | nil,
          hooks_url: String.t(),
          html_url: String.t(),
          id: integer,
          is_template: boolean | nil,
          issue_comment_url: String.t(),
          issue_events_url: String.t(),
          issues_url: String.t(),
          keys_url: String.t(),
          labels_url: String.t(),
          language: String.t() | nil,
          languages_url: String.t(),
          license: GitHub.Repository.License.minimal() | nil,
          merges_url: String.t(),
          milestones_url: String.t(),
          mirror_url: String.t() | nil,
          name: String.t(),
          network_count: integer | nil,
          node_id: String.t(),
          notifications_url: String.t(),
          open_issues: integer | nil,
          open_issues_count: integer | nil,
          owner: GitHub.User.simple(),
          permissions: GitHub.Repository.Permissions.minimal() | nil,
          private: boolean,
          pulls_url: String.t(),
          pushed_at: DateTime.t() | nil,
          releases_url: String.t(),
          role_name: String.t() | nil,
          security_and_analysis: GitHub.SecurityAndAnalysis.t() | nil,
          size: integer | nil,
          ssh_url: String.t() | nil,
          stargazers_count: integer | nil,
          stargazers_url: String.t(),
          statuses_url: String.t(),
          subscribers_count: integer | nil,
          subscribers_url: String.t(),
          subscription_url: String.t(),
          svn_url: String.t() | nil,
          tags_url: String.t(),
          teams_url: String.t(),
          temp_clone_token: String.t() | nil,
          topics: [String.t()] | nil,
          trees_url: String.t(),
          updated_at: DateTime.t() | nil,
          url: String.t(),
          visibility: String.t() | nil,
          watchers: integer | nil,
          watchers_count: integer | nil,
          web_commit_signoff_required: boolean | nil
        }

  @type simple :: %__MODULE__{
          __info__: map,
          archive_url: String.t(),
          assignees_url: String.t(),
          blobs_url: String.t(),
          branches_url: String.t(),
          collaborators_url: String.t(),
          comments_url: String.t(),
          commits_url: String.t(),
          compare_url: String.t(),
          contents_url: String.t(),
          contributors_url: String.t(),
          deployments_url: String.t(),
          description: String.t() | nil,
          downloads_url: String.t(),
          events_url: String.t(),
          fork: boolean,
          forks_url: String.t(),
          full_name: String.t(),
          git_commits_url: String.t(),
          git_refs_url: String.t(),
          git_tags_url: String.t(),
          hooks_url: String.t(),
          html_url: String.t(),
          id: integer,
          issue_comment_url: String.t(),
          issue_events_url: String.t(),
          issues_url: String.t(),
          keys_url: String.t(),
          labels_url: String.t(),
          languages_url: String.t(),
          merges_url: String.t(),
          milestones_url: String.t(),
          name: String.t(),
          node_id: String.t(),
          notifications_url: String.t(),
          owner: GitHub.User.simple(),
          private: boolean,
          pulls_url: String.t(),
          releases_url: String.t(),
          stargazers_url: String.t(),
          statuses_url: String.t(),
          subscribers_url: String.t(),
          subscription_url: String.t(),
          tags_url: String.t(),
          teams_url: String.t(),
          trees_url: String.t(),
          url: String.t()
        }

  @type t :: %__MODULE__{
          __info__: map,
          allow_auto_merge: boolean | nil,
          allow_forking: boolean | nil,
          allow_merge_commit: boolean | nil,
          allow_rebase_merge: boolean | nil,
          allow_squash_merge: boolean | nil,
          allow_update_branch: boolean | nil,
          anonymous_access_enabled: boolean | nil,
          archive_url: String.t(),
          archived: boolean,
          assignees_url: String.t(),
          blobs_url: String.t(),
          branches_url: String.t(),
          clone_url: String.t(),
          collaborators_url: String.t(),
          comments_url: String.t(),
          commits_url: String.t(),
          compare_url: String.t(),
          contents_url: String.t(),
          contributors_url: String.t(),
          created_at: DateTime.t() | nil,
          default_branch: String.t(),
          delete_branch_on_merge: boolean | nil,
          deployments_url: String.t(),
          description: String.t() | nil,
          disabled: boolean,
          downloads_url: String.t(),
          events_url: String.t(),
          fork: boolean,
          forks: integer,
          forks_count: integer,
          forks_url: String.t(),
          full_name: String.t(),
          git_commits_url: String.t(),
          git_refs_url: String.t(),
          git_tags_url: String.t(),
          git_url: String.t(),
          has_discussions: boolean | nil,
          has_downloads: boolean,
          has_issues: boolean,
          has_pages: boolean,
          has_projects: boolean,
          has_wiki: boolean,
          homepage: String.t() | nil,
          hooks_url: String.t(),
          html_url: String.t(),
          id: integer,
          is_template: boolean | nil,
          issue_comment_url: String.t(),
          issue_events_url: String.t(),
          issues_url: String.t(),
          keys_url: String.t(),
          labels_url: String.t(),
          language: String.t() | nil,
          languages_url: String.t(),
          license: GitHub.License.simple() | nil,
          master_branch: String.t() | nil,
          merge_commit_message: String.t() | nil,
          merge_commit_title: String.t() | nil,
          merges_url: String.t(),
          milestones_url: String.t(),
          mirror_url: String.t() | nil,
          name: String.t(),
          node_id: String.t(),
          notifications_url: String.t(),
          open_issues: integer,
          open_issues_count: integer,
          owner: GitHub.User.simple(),
          permissions: GitHub.Repository.Permissions.t() | nil,
          private: boolean,
          pulls_url: String.t(),
          pushed_at: DateTime.t() | nil,
          releases_url: String.t(),
          size: integer,
          squash_merge_commit_message: String.t() | nil,
          squash_merge_commit_title: String.t() | nil,
          ssh_url: String.t(),
          stargazers_count: integer,
          stargazers_url: String.t(),
          starred_at: String.t() | nil,
          statuses_url: String.t(),
          subscribers_url: String.t(),
          subscription_url: String.t(),
          svn_url: String.t(),
          tags_url: String.t(),
          teams_url: String.t(),
          temp_clone_token: String.t() | nil,
          topics: [String.t()] | nil,
          trees_url: String.t(),
          updated_at: DateTime.t() | nil,
          url: String.t(),
          use_squash_pr_title_as_default: boolean | nil,
          visibility: String.t() | nil,
          watchers: integer,
          watchers_count: integer,
          web_commit_signoff_required: boolean | nil
        }

  defstruct [
    :__info__,
    :allow_auto_merge,
    :allow_forking,
    :allow_merge_commit,
    :allow_rebase_merge,
    :allow_squash_merge,
    :allow_update_branch,
    :anonymous_access_enabled,
    :archive_url,
    :archived,
    :assignees_url,
    :blobs_url,
    :branches_url,
    :clone_url,
    :code_of_conduct,
    :collaborators_url,
    :comments_url,
    :commits_url,
    :compare_url,
    :contents_url,
    :contributors_url,
    :created_at,
    :custom_properties,
    :default_branch,
    :delete_branch_on_merge,
    :deployments_url,
    :description,
    :disabled,
    :downloads_url,
    :events_url,
    :fork,
    :forks,
    :forks_count,
    :forks_url,
    :full_name,
    :git_commits_url,
    :git_refs_url,
    :git_tags_url,
    :git_url,
    :has_discussions,
    :has_downloads,
    :has_issues,
    :has_pages,
    :has_projects,
    :has_wiki,
    :homepage,
    :hooks_url,
    :html_url,
    :id,
    :is_template,
    :issue_comment_url,
    :issue_events_url,
    :issues_url,
    :keys_url,
    :labels_url,
    :language,
    :languages_url,
    :license,
    :master_branch,
    :merge_commit_message,
    :merge_commit_title,
    :merges_url,
    :milestones_url,
    :mirror_url,
    :name,
    :network_count,
    :node_id,
    :notifications_url,
    :open_issues,
    :open_issues_count,
    :organization,
    :owner,
    :parent,
    :permissions,
    :private,
    :pulls_url,
    :pushed_at,
    :releases_url,
    :role_name,
    :security_and_analysis,
    :size,
    :source,
    :squash_merge_commit_message,
    :squash_merge_commit_title,
    :ssh_url,
    :stargazers_count,
    :stargazers_url,
    :starred_at,
    :statuses_url,
    :subscribers_count,
    :subscribers_url,
    :subscription_url,
    :svn_url,
    :tags_url,
    :teams_url,
    :temp_clone_token,
    :template_repository,
    :topics,
    :trees_url,
    :updated_at,
    :url,
    :use_squash_pr_title_as_default,
    :visibility,
    :watchers,
    :watchers_count,
    :web_commit_signoff_required
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:full) do
    [
      allow_auto_merge: :boolean,
      allow_forking: :boolean,
      allow_merge_commit: :boolean,
      allow_rebase_merge: :boolean,
      allow_squash_merge: :boolean,
      allow_update_branch: :boolean,
      anonymous_access_enabled: :boolean,
      archive_url: {:string, :generic},
      archived: :boolean,
      assignees_url: {:string, :generic},
      blobs_url: {:string, :generic},
      branches_url: {:string, :generic},
      clone_url: {:string, :generic},
      code_of_conduct: {GitHub.CodeOfConduct, :simple},
      collaborators_url: {:string, :generic},
      comments_url: {:string, :generic},
      commits_url: {:string, :generic},
      compare_url: {:string, :generic},
      contents_url: {:string, :generic},
      contributors_url: {:string, :uri},
      created_at: {:string, :date_time},
      custom_properties: :map,
      default_branch: {:string, :generic},
      delete_branch_on_merge: :boolean,
      deployments_url: {:string, :uri},
      description: {:union, [{:string, :generic}, :null]},
      disabled: :boolean,
      downloads_url: {:string, :uri},
      events_url: {:string, :uri},
      fork: :boolean,
      forks: :integer,
      forks_count: :integer,
      forks_url: {:string, :uri},
      full_name: {:string, :generic},
      git_commits_url: {:string, :generic},
      git_refs_url: {:string, :generic},
      git_tags_url: {:string, :generic},
      git_url: {:string, :generic},
      has_discussions: :boolean,
      has_downloads: :boolean,
      has_issues: :boolean,
      has_pages: :boolean,
      has_projects: :boolean,
      has_wiki: :boolean,
      homepage: {:union, [{:string, :uri}, :null]},
      hooks_url: {:string, :uri},
      html_url: {:string, :uri},
      id: :integer,
      is_template: :boolean,
      issue_comment_url: {:string, :generic},
      issue_events_url: {:string, :generic},
      issues_url: {:string, :generic},
      keys_url: {:string, :generic},
      labels_url: {:string, :generic},
      language: {:union, [{:string, :generic}, :null]},
      languages_url: {:string, :uri},
      license: {:union, [{GitHub.License, :simple}, :null]},
      master_branch: {:string, :generic},
      merge_commit_message: {:enum, ["PR_BODY", "PR_TITLE", "BLANK"]},
      merge_commit_title: {:enum, ["PR_TITLE", "MERGE_MESSAGE"]},
      merges_url: {:string, :uri},
      milestones_url: {:string, :generic},
      mirror_url: {:union, [{:string, :uri}, :null]},
      name: {:string, :generic},
      network_count: :integer,
      node_id: {:string, :generic},
      notifications_url: {:string, :generic},
      open_issues: :integer,
      open_issues_count: :integer,
      organization: {:union, [{GitHub.User, :simple}, :null]},
      owner: {GitHub.User, :simple},
      parent: {GitHub.Repository, :t},
      permissions: {GitHub.Repository.Permissions, :full},
      private: :boolean,
      pulls_url: {:string, :generic},
      pushed_at: {:string, :date_time},
      releases_url: {:string, :generic},
      security_and_analysis: {:union, [{GitHub.SecurityAndAnalysis, :t}, :null]},
      size: :integer,
      source: {GitHub.Repository, :t},
      squash_merge_commit_message: {:enum, ["PR_BODY", "COMMIT_MESSAGES", "BLANK"]},
      squash_merge_commit_title: {:enum, ["PR_TITLE", "COMMIT_OR_PR_TITLE"]},
      ssh_url: {:string, :generic},
      stargazers_count: :integer,
      stargazers_url: {:string, :uri},
      statuses_url: {:string, :generic},
      subscribers_count: :integer,
      subscribers_url: {:string, :uri},
      subscription_url: {:string, :uri},
      svn_url: {:string, :uri},
      tags_url: {:string, :uri},
      teams_url: {:string, :uri},
      temp_clone_token: {:union, [{:string, :generic}, :null]},
      template_repository: {:union, [{GitHub.Repository, :t}, :null]},
      topics: [string: :generic],
      trees_url: {:string, :generic},
      updated_at: {:string, :date_time},
      url: {:string, :uri},
      use_squash_pr_title_as_default: :boolean,
      visibility: {:string, :generic},
      watchers: :integer,
      watchers_count: :integer,
      web_commit_signoff_required: :boolean
    ]
  end

  def __fields__(:minimal) do
    [
      allow_forking: :boolean,
      archive_url: {:string, :generic},
      archived: :boolean,
      assignees_url: {:string, :generic},
      blobs_url: {:string, :generic},
      branches_url: {:string, :generic},
      clone_url: {:string, :generic},
      code_of_conduct: {GitHub.CodeOfConduct, :t},
      collaborators_url: {:string, :generic},
      comments_url: {:string, :generic},
      commits_url: {:string, :generic},
      compare_url: {:string, :generic},
      contents_url: {:string, :generic},
      contributors_url: {:string, :uri},
      created_at: {:union, [{:string, :date_time}, :null]},
      default_branch: {:string, :generic},
      delete_branch_on_merge: :boolean,
      deployments_url: {:string, :uri},
      description: {:union, [{:string, :generic}, :null]},
      disabled: :boolean,
      downloads_url: {:string, :uri},
      events_url: {:string, :uri},
      fork: :boolean,
      forks: :integer,
      forks_count: :integer,
      forks_url: {:string, :uri},
      full_name: {:string, :generic},
      git_commits_url: {:string, :generic},
      git_refs_url: {:string, :generic},
      git_tags_url: {:string, :generic},
      git_url: {:string, :generic},
      has_discussions: :boolean,
      has_downloads: :boolean,
      has_issues: :boolean,
      has_pages: :boolean,
      has_projects: :boolean,
      has_wiki: :boolean,
      homepage: {:union, [{:string, :generic}, :null]},
      hooks_url: {:string, :uri},
      html_url: {:string, :uri},
      id: :integer,
      is_template: :boolean,
      issue_comment_url: {:string, :generic},
      issue_events_url: {:string, :generic},
      issues_url: {:string, :generic},
      keys_url: {:string, :generic},
      labels_url: {:string, :generic},
      language: {:union, [{:string, :generic}, :null]},
      languages_url: {:string, :uri},
      license: {:union, [{GitHub.Repository.License, :minimal}, :null]},
      merges_url: {:string, :uri},
      milestones_url: {:string, :generic},
      mirror_url: {:union, [{:string, :generic}, :null]},
      name: {:string, :generic},
      network_count: :integer,
      node_id: {:string, :generic},
      notifications_url: {:string, :generic},
      open_issues: :integer,
      open_issues_count: :integer,
      owner: {GitHub.User, :simple},
      permissions: {GitHub.Repository.Permissions, :minimal},
      private: :boolean,
      pulls_url: {:string, :generic},
      pushed_at: {:union, [{:string, :date_time}, :null]},
      releases_url: {:string, :generic},
      role_name: {:string, :generic},
      security_and_analysis: {:union, [{GitHub.SecurityAndAnalysis, :t}, :null]},
      size: :integer,
      ssh_url: {:string, :generic},
      stargazers_count: :integer,
      stargazers_url: {:string, :uri},
      statuses_url: {:string, :generic},
      subscribers_count: :integer,
      subscribers_url: {:string, :uri},
      subscription_url: {:string, :uri},
      svn_url: {:string, :generic},
      tags_url: {:string, :uri},
      teams_url: {:string, :uri},
      temp_clone_token: {:string, :generic},
      topics: [string: :generic],
      trees_url: {:string, :generic},
      updated_at: {:union, [{:string, :date_time}, :null]},
      url: {:string, :uri},
      visibility: {:string, :generic},
      watchers: :integer,
      watchers_count: :integer,
      web_commit_signoff_required: :boolean
    ]
  end

  def __fields__(:simple) do
    [
      archive_url: {:string, :generic},
      assignees_url: {:string, :generic},
      blobs_url: {:string, :generic},
      branches_url: {:string, :generic},
      collaborators_url: {:string, :generic},
      comments_url: {:string, :generic},
      commits_url: {:string, :generic},
      compare_url: {:string, :generic},
      contents_url: {:string, :generic},
      contributors_url: {:string, :uri},
      deployments_url: {:string, :uri},
      description: {:union, [{:string, :generic}, :null]},
      downloads_url: {:string, :uri},
      events_url: {:string, :uri},
      fork: :boolean,
      forks_url: {:string, :uri},
      full_name: {:string, :generic},
      git_commits_url: {:string, :generic},
      git_refs_url: {:string, :generic},
      git_tags_url: {:string, :generic},
      hooks_url: {:string, :uri},
      html_url: {:string, :uri},
      id: :integer,
      issue_comment_url: {:string, :generic},
      issue_events_url: {:string, :generic},
      issues_url: {:string, :generic},
      keys_url: {:string, :generic},
      labels_url: {:string, :generic},
      languages_url: {:string, :uri},
      merges_url: {:string, :uri},
      milestones_url: {:string, :generic},
      name: {:string, :generic},
      node_id: {:string, :generic},
      notifications_url: {:string, :generic},
      owner: {GitHub.User, :simple},
      private: :boolean,
      pulls_url: {:string, :generic},
      releases_url: {:string, :generic},
      stargazers_url: {:string, :uri},
      statuses_url: {:string, :generic},
      subscribers_url: {:string, :uri},
      subscription_url: {:string, :uri},
      tags_url: {:string, :uri},
      teams_url: {:string, :uri},
      trees_url: {:string, :generic},
      url: {:string, :uri}
    ]
  end

  def __fields__(:t) do
    [
      allow_auto_merge: :boolean,
      allow_forking: :boolean,
      allow_merge_commit: :boolean,
      allow_rebase_merge: :boolean,
      allow_squash_merge: :boolean,
      allow_update_branch: :boolean,
      anonymous_access_enabled: :boolean,
      archive_url: {:string, :generic},
      archived: :boolean,
      assignees_url: {:string, :generic},
      blobs_url: {:string, :generic},
      branches_url: {:string, :generic},
      clone_url: {:string, :generic},
      collaborators_url: {:string, :generic},
      comments_url: {:string, :generic},
      commits_url: {:string, :generic},
      compare_url: {:string, :generic},
      contents_url: {:string, :generic},
      contributors_url: {:string, :uri},
      created_at: {:union, [{:string, :date_time}, :null]},
      default_branch: {:string, :generic},
      delete_branch_on_merge: :boolean,
      deployments_url: {:string, :uri},
      description: {:union, [{:string, :generic}, :null]},
      disabled: :boolean,
      downloads_url: {:string, :uri},
      events_url: {:string, :uri},
      fork: :boolean,
      forks: :integer,
      forks_count: :integer,
      forks_url: {:string, :uri},
      full_name: {:string, :generic},
      git_commits_url: {:string, :generic},
      git_refs_url: {:string, :generic},
      git_tags_url: {:string, :generic},
      git_url: {:string, :generic},
      has_discussions: :boolean,
      has_downloads: :boolean,
      has_issues: :boolean,
      has_pages: :boolean,
      has_projects: :boolean,
      has_wiki: :boolean,
      homepage: {:union, [{:string, :uri}, :null]},
      hooks_url: {:string, :uri},
      html_url: {:string, :uri},
      id: :integer,
      is_template: :boolean,
      issue_comment_url: {:string, :generic},
      issue_events_url: {:string, :generic},
      issues_url: {:string, :generic},
      keys_url: {:string, :generic},
      labels_url: {:string, :generic},
      language: {:union, [{:string, :generic}, :null]},
      languages_url: {:string, :uri},
      license: {:union, [{GitHub.License, :simple}, :null]},
      master_branch: {:string, :generic},
      merge_commit_message: {:enum, ["PR_BODY", "PR_TITLE", "BLANK"]},
      merge_commit_title: {:enum, ["PR_TITLE", "MERGE_MESSAGE"]},
      merges_url: {:string, :uri},
      milestones_url: {:string, :generic},
      mirror_url: {:union, [{:string, :uri}, :null]},
      name: {:string, :generic},
      node_id: {:string, :generic},
      notifications_url: {:string, :generic},
      open_issues: :integer,
      open_issues_count: :integer,
      owner: {GitHub.User, :simple},
      permissions: {GitHub.Repository.Permissions, :t},
      private: :boolean,
      pulls_url: {:string, :generic},
      pushed_at: {:union, [{:string, :date_time}, :null]},
      releases_url: {:string, :generic},
      size: :integer,
      squash_merge_commit_message: {:enum, ["PR_BODY", "COMMIT_MESSAGES", "BLANK"]},
      squash_merge_commit_title: {:enum, ["PR_TITLE", "COMMIT_OR_PR_TITLE"]},
      ssh_url: {:string, :generic},
      stargazers_count: :integer,
      stargazers_url: {:string, :uri},
      starred_at: {:string, :generic},
      statuses_url: {:string, :generic},
      subscribers_url: {:string, :uri},
      subscription_url: {:string, :uri},
      svn_url: {:string, :uri},
      tags_url: {:string, :uri},
      teams_url: {:string, :uri},
      temp_clone_token: {:string, :generic},
      topics: [string: :generic],
      trees_url: {:string, :generic},
      updated_at: {:union, [{:string, :date_time}, :null]},
      url: {:string, :uri},
      use_squash_pr_title_as_default: :boolean,
      visibility: {:string, :generic},
      watchers: :integer,
      watchers_count: :integer,
      web_commit_signoff_required: :boolean
    ]
  end
end
