defmodule GitHub.EnterpriseAdmin do
  @moduledoc """
  Provides API endpoints related to enterprise admin
  """

  @default_client GitHub.Client

  @doc """
  Add custom labels to a self-hosted runner for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#add-custom-labels-to-a-self-hosted-runner-for-an-enterprise)

  """
  @spec add_custom_labels_to_self_hosted_runner_for_enterprise(String.t(), integer, map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def add_custom_labels_to_self_hosted_runner_for_enterprise(
        enterprise,
        runner_id,
        body,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runners/#{runner_id}/labels",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, :map},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Add organization access to a self-hosted runner group in an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#add-organization-access-to-a-self-hosted-runner-group-in-an-enterprise)

  """
  @spec add_org_access_to_self_hosted_runner_group_in_enterprise(
          String.t(),
          integer,
          integer,
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def add_org_access_to_self_hosted_runner_group_in_enterprise(
        enterprise,
        runner_group_id,
        org_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url:
        "/enterprises/#{enterprise}/actions/runner-groups/#{runner_group_id}/organizations/#{org_id}",
      method: :put,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Add a self-hosted runner to a group for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#add-a-self-hosted-runner-to-a-group-for-an-enterprise)

  """
  @spec add_self_hosted_runner_to_group_for_enterprise(String.t(), integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_self_hosted_runner_to_group_for_enterprise(
        enterprise,
        runner_group_id,
        runner_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url:
        "/enterprises/#{enterprise}/actions/runner-groups/#{runner_group_id}/runners/#{runner_id}",
      method: :put,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Create a registration token for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#create-a-registration-token-for-an-enterprise)

  """
  @spec create_registration_token_for_enterprise(String.t(), keyword) ::
          {:ok, GitHub.AuthenticationToken.t()} | {:error, GitHub.Error.t()}
  def create_registration_token_for_enterprise(enterprise, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runners/registration-token",
      method: :post,
      response: [{201, {GitHub.AuthenticationToken, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a remove token for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#create-a-remove-token-for-an-enterprise)

  """
  @spec create_remove_token_for_enterprise(String.t(), keyword) ::
          {:ok, GitHub.AuthenticationToken.t()} | {:error, GitHub.Error.t()}
  def create_remove_token_for_enterprise(enterprise, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runners/remove-token",
      method: :post,
      response: [{201, {GitHub.AuthenticationToken, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a self-hosted runner group for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#create-self-hosted-runner-group-for-an-enterprise)

  """
  @spec create_self_hosted_runner_group_for_enterprise(String.t(), map, keyword) ::
          {:ok, GitHub.Actions.Runner.GroupsEnterprise.t()} | {:error, GitHub.Error.t()}
  def create_self_hosted_runner_group_for_enterprise(enterprise, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runner-groups",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Actions.Runner.GroupsEnterprise, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a self-hosted runner from an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#delete-self-hosted-runner-from-an-enterprise)

  """
  @spec delete_self_hosted_runner_from_enterprise(String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_self_hosted_runner_from_enterprise(enterprise, runner_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runners/#{runner_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a self-hosted runner group from an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#delete-a-self-hosted-runner-group-from-an-enterprise)

  """
  @spec delete_self_hosted_runner_group_from_enterprise(String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_self_hosted_runner_group_from_enterprise(enterprise, runner_group_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runner-groups/#{runner_group_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Disable a selected organization for GitHub Actions in an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#disable-a-selected-organization-for-github-actions-in-an-enterprise)

  """
  @spec disable_selected_organization_github_actions_enterprise(String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def disable_selected_organization_github_actions_enterprise(enterprise, org_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/permissions/organizations/#{org_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Enable a selected organization for GitHub Actions in an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#enable-a-selected-organization-for-github-actions-in-an-enterprise)

  """
  @spec enable_selected_organization_github_actions_enterprise(String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def enable_selected_organization_github_actions_enterprise(enterprise, org_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/permissions/organizations/#{org_id}",
      method: :put,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Get allowed actions and reusable workflows for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-allowed-actions-for-an-enterprise)

  """
  @spec get_allowed_actions_enterprise(String.t(), keyword) ::
          {:ok, GitHub.SelectedActions.t()} | {:error, GitHub.Error.t()}
  def get_allowed_actions_enterprise(enterprise, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/permissions/selected-actions",
      method: :get,
      response: [{200, {GitHub.SelectedActions, :t}}],
      opts: opts
    })
  end

  @doc """
  Get GitHub Actions permissions for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-github-actions-permissions-for-an-enterprise)

  """
  @spec get_github_actions_permissions_enterprise(String.t(), keyword) ::
          {:ok, GitHub.Actions.EnterprisePermissions.t()} | {:error, GitHub.Error.t()}
  def get_github_actions_permissions_enterprise(enterprise, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/permissions",
      method: :get,
      response: [{200, {GitHub.Actions.EnterprisePermissions, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a self-hosted runner for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-a-self-hosted-runner-for-an-enterprise)

  """
  @spec get_self_hosted_runner_for_enterprise(String.t(), integer, keyword) ::
          {:ok, GitHub.Actions.Runner.t()} | {:error, GitHub.Error.t()}
  def get_self_hosted_runner_for_enterprise(enterprise, runner_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runners/#{runner_id}",
      method: :get,
      response: [{200, {GitHub.Actions.Runner, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a self-hosted runner group for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-a-self-hosted-runner-group-for-an-enterprise)

  """
  @spec get_self_hosted_runner_group_for_enterprise(String.t(), integer, keyword) ::
          {:ok, GitHub.Actions.Runner.GroupsEnterprise.t()} | {:error, GitHub.Error.t()}
  def get_self_hosted_runner_group_for_enterprise(enterprise, runner_group_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runner-groups/#{runner_group_id}",
      method: :get,
      response: [{200, {GitHub.Actions.Runner.GroupsEnterprise, :t}}],
      opts: opts
    })
  end

  @doc """
  Get GitHub Enterprise Server statistics

  ## Options

    * `date_start` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/overview/resources-in-the-rest-api#link-header). If specified, the query only searches for events after this cursor.
    * `date_end` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/overview/resources-in-the-rest-api#link-header). If specified, the query only searches for events before this cursor.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/enterprise-admin#get-github-enterprise-server-statistics)

  """
  @spec get_server_statistics(String.t(), keyword) :: {:ok, [map]} | {:error, GitHub.Error.t()}
  def get_server_statistics(enterprise_or_org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:date_end, :date_start])

    client.request(%{
      url: "/enterprise-installation/#{enterprise_or_org}/server-statistics",
      method: :get,
      query: query,
      response: [{200, {:array, :map}}],
      opts: opts
    })
  end

  @doc """
  List labels for a self-hosted runner for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-labels-for-a-self-hosted-runner-for-an-enterprise)

  """
  @spec list_labels_for_self_hosted_runner_for_enterprise(String.t(), integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_labels_for_self_hosted_runner_for_enterprise(enterprise, runner_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runners/#{runner_id}/labels",
      method: :get,
      response: [{200, :map}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List organization access to a self-hosted runner group in an enterprise

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-organization-access-to-a-self-hosted-runner-group-in-a-enterprise)

  """
  @spec list_org_access_to_self_hosted_runner_group_in_enterprise(String.t(), integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_org_access_to_self_hosted_runner_group_in_enterprise(
        enterprise,
        runner_group_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runner-groups/#{runner_group_id}/organizations",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List runner applications for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-runner-applications-for-an-enterprise)

  """
  @spec list_runner_applications_for_enterprise(String.t(), keyword) ::
          {:ok, [GitHub.Actions.Runner.Application.t()]} | {:error, GitHub.Error.t()}
  def list_runner_applications_for_enterprise(enterprise, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runners/downloads",
      method: :get,
      response: [{200, {:array, {GitHub.Actions.Runner.Application, :t}}}],
      opts: opts
    })
  end

  @doc """
  List selected organizations enabled for GitHub Actions in an enterprise

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-selected-organizations-enabled-for-github-actions-in-an-enterprise)

  """
  @spec list_selected_organizations_enabled_github_actions_enterprise(String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_selected_organizations_enabled_github_actions_enterprise(enterprise, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/permissions/organizations",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List self-hosted runner groups for an enterprise

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `visible_to_organization` (String.t()): Only return runner groups that are allowed to be used by this organization.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-self-hosted-runner-groups-for-an-enterprise)

  """
  @spec list_self_hosted_runner_groups_for_enterprise(String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_self_hosted_runner_groups_for_enterprise(enterprise, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :visible_to_organization])

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runner-groups",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List self-hosted runners for an enterprise

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-self-hosted-runners-for-an-enterprise)

  """
  @spec list_self_hosted_runners_for_enterprise(String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_self_hosted_runners_for_enterprise(enterprise, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runners",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List self-hosted runners in a group for an enterprise

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-self-hosted-runners-in-a-group-for-an-enterprise)

  """
  @spec list_self_hosted_runners_in_group_for_enterprise(String.t(), integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_self_hosted_runners_in_group_for_enterprise(enterprise, runner_group_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runner-groups/#{runner_group_id}/runners",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Remove all custom labels from a self-hosted runner for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#remove-all-custom-labels-from-a-self-hosted-runner-for-an-enterprise)

  """
  @spec remove_all_custom_labels_from_self_hosted_runner_for_enterprise(
          String.t(),
          integer,
          keyword
        ) :: {:ok, map} | {:error, GitHub.Error.t()}
  def remove_all_custom_labels_from_self_hosted_runner_for_enterprise(
        enterprise,
        runner_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runners/#{runner_id}/labels",
      method: :delete,
      response: [
        {200, :map},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove a custom label from a self-hosted runner for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#remove-a-custom-label-from-a-self-hosted-runner-for-an-enterprise)

  """
  @spec remove_custom_label_from_self_hosted_runner_for_enterprise(
          String.t(),
          integer,
          String.t(),
          keyword
        ) :: {:ok, map} | {:error, GitHub.Error.t()}
  def remove_custom_label_from_self_hosted_runner_for_enterprise(
        enterprise,
        runner_id,
        name,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runners/#{runner_id}/labels/#{name}",
      method: :delete,
      response: [
        {200, :map},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove organization access to a self-hosted runner group in an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#remove-organization-access-to-a-self-hosted-runner-group-in-an-enterprise)

  """
  @spec remove_org_access_to_self_hosted_runner_group_in_enterprise(
          String.t(),
          integer,
          integer,
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def remove_org_access_to_self_hosted_runner_group_in_enterprise(
        enterprise,
        runner_group_id,
        org_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url:
        "/enterprises/#{enterprise}/actions/runner-groups/#{runner_group_id}/organizations/#{org_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Remove a self-hosted runner from a group for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#remove-a-self-hosted-runner-from-a-group-for-an-enterprise)

  """
  @spec remove_self_hosted_runner_from_group_for_enterprise(String.t(), integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_self_hosted_runner_from_group_for_enterprise(
        enterprise,
        runner_group_id,
        runner_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url:
        "/enterprises/#{enterprise}/actions/runner-groups/#{runner_group_id}/runners/#{runner_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Get code security and analysis features for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/enterprise-admin#get-code-security-analysis-features-for-an-enterprise)

  """
  @spec secret_scanning_get_security_analysis_settings_for_enterprise(String.t(), keyword) ::
          {:ok, GitHub.EnterpriseSecurityAnalysisSettings.t()} | {:error, GitHub.Error.t()}
  def secret_scanning_get_security_analysis_settings_for_enterprise(enterprise, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/code_security_and_analysis",
      method: :get,
      response: [
        {200, {GitHub.EnterpriseSecurityAnalysisSettings, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update code security and analysis features for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/enterprise-admin#update-code-security-and-analysis-features-for-an-enterprise)

  """
  @spec secret_scanning_patch_security_analysis_settings_for_enterprise(String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def secret_scanning_patch_security_analysis_settings_for_enterprise(
        enterprise,
        body,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/code_security_and_analysis",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}, {422, nil}],
      opts: opts
    })
  end

  @doc """
  Enable or disable a security feature

  ## Resources

    * [API method documentation](https://docs.github.com/rest/enterprise-admin#enable-or-disable-a-security-feature)

  """
  @spec secret_scanning_post_security_product_enablement_for_enterprise(
          String.t(),
          String.t(),
          String.t(),
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def secret_scanning_post_security_product_enablement_for_enterprise(
        enterprise,
        security_product,
        enablement,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/#{security_product}/#{enablement}",
      method: :post,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}, {422, nil}],
      opts: opts
    })
  end

  @doc """
  Set allowed actions and reusable workflows for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-allowed-actions-for-an-enterprise)

  """
  @spec set_allowed_actions_enterprise(String.t(), GitHub.SelectedActions.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_allowed_actions_enterprise(enterprise, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/permissions/selected-actions",
      body: body,
      method: :put,
      request: [{"application/json", {GitHub.SelectedActions, :t}}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set custom labels for a self-hosted runner for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-custom-labels-for-a-self-hosted-runner-for-an-enterprise)

  """
  @spec set_custom_labels_for_self_hosted_runner_for_enterprise(String.t(), integer, map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def set_custom_labels_for_self_hosted_runner_for_enterprise(
        enterprise,
        runner_id,
        body,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runners/#{runner_id}/labels",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, :map},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Set GitHub Actions permissions for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-github-actions-permissions-for-an-enterprise)

  """
  @spec set_github_actions_permissions_enterprise(String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_github_actions_permissions_enterprise(enterprise, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/permissions",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set organization access for a self-hosted runner group in an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-organization-access-to-a-self-hosted-runner-group-in-an-enterprise)

  """
  @spec set_org_access_to_self_hosted_runner_group_in_enterprise(
          String.t(),
          integer,
          map,
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def set_org_access_to_self_hosted_runner_group_in_enterprise(
        enterprise,
        runner_group_id,
        body,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runner-groups/#{runner_group_id}/organizations",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set selected organizations enabled for GitHub Actions in an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-selected-organizations-enabled-for-github-actions-in-an-enterprise)

  """
  @spec set_selected_organizations_enabled_github_actions_enterprise(String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_selected_organizations_enabled_github_actions_enterprise(enterprise, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/permissions/organizations",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set self-hosted runners in a group for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-self-hosted-runners-in-a-group-for-an-enterprise)

  """
  @spec set_self_hosted_runners_in_group_for_enterprise(String.t(), integer, map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_self_hosted_runners_in_group_for_enterprise(
        enterprise,
        runner_group_id,
        body,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runner-groups/#{runner_group_id}/runners",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Update a self-hosted runner group for an enterprise

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#update-a-self-hosted-runner-group-for-an-enterprise)

  """
  @spec update_self_hosted_runner_group_for_enterprise(String.t(), integer, map, keyword) ::
          {:ok, GitHub.Actions.Runner.GroupsEnterprise.t()} | {:error, GitHub.Error.t()}
  def update_self_hosted_runner_group_for_enterprise(
        enterprise,
        runner_group_id,
        body,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/enterprises/#{enterprise}/actions/runner-groups/#{runner_group_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Actions.Runner.GroupsEnterprise, :t}}],
      opts: opts
    })
  end
end
