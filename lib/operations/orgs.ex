defmodule GitHub.Orgs do
  @moduledoc """
  Provides API endpoints related to orgs
  """

  @default_client GitHub.Client

  @doc """
  Add a security manager team

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#add-a-security-manager-team)

  """
  @spec add_security_manager_team(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_security_manager_team(org, team_slug, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug],
      call: {GitHub.Orgs, :add_security_manager_team},
      url: "/orgs/#{org}/security-managers/teams/#{team_slug}",
      method: :put,
      response: [{204, nil}, {409, nil}],
      opts: opts
    })
  end

  @doc """
  Block a user from an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#block-a-user-from-an-organization)

  """
  @spec block_user(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def block_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :block_user},
      url: "/orgs/#{org}/blocks/#{username}",
      method: :put,
      response: [{204, nil}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Cancel an organization invitation

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#cancel-an-organization-invitation)

  """
  @spec cancel_invitation(String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def cancel_invitation(org, invitation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, invitation_id: invitation_id],
      call: {GitHub.Orgs, :cancel_invitation},
      url: "/orgs/#{org}/invitations/#{invitation_id}",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Check if a user is blocked by an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#check-if-a-user-is-blocked-by-an-organization)

  """
  @spec check_blocked_user(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def check_blocked_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :check_blocked_user},
      url: "/orgs/#{org}/blocks/#{username}",
      method: :get,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Check organization membership for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#check-organization-membership-for-a-user)

  """
  @spec check_membership_for_user(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def check_membership_for_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :check_membership_for_user},
      url: "/orgs/#{org}/members/#{username}",
      method: :get,
      response: [{204, nil}, {302, nil}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Check public organization membership for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#check-public-organization-membership-for-a-user)

  """
  @spec check_public_membership_for_user(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def check_public_membership_for_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :check_public_membership_for_user},
      url: "/orgs/#{org}/public_members/#{username}",
      method: :get,
      response: [{204, nil}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Convert an organization member to outside collaborator

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#convert-an-organization-member-to-outside-collaborator)

  """
  @spec convert_member_to_outside_collaborator(String.t(), String.t(), map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def convert_member_to_outside_collaborator(org, username, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username, body: body],
      call: {GitHub.Orgs, :convert_member_to_outside_collaborator},
      url: "/orgs/#{org}/outside_collaborators/#{username}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{202, :map}, {204, nil}, {403, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create an organization invitation

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#create-an-organization-invitation)

  """
  @spec create_invitation(String.t(), map, keyword) ::
          {:ok, GitHub.Organization.Invitation.t()} | {:error, GitHub.Error.t()}
  def create_invitation(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Orgs, :create_invitation},
      url: "/orgs/#{org}/invitations",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Organization.Invitation, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create an organization webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#create-an-organization-webhook)

  """
  @spec create_webhook(String.t(), map, keyword) ::
          {:ok, GitHub.OrgHook.t()} | {:error, GitHub.Error.t()}
  def create_webhook(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Orgs, :create_webhook},
      url: "/orgs/#{org}/hooks",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.OrgHook, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs/#delete-an-organization)

  """
  @spec delete(String.t(), keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def delete(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :delete},
      url: "/orgs/#{org}",
      method: :delete,
      response: [{202, :map}, {403, {GitHub.BasicError, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete an organization webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#delete-an-organization-webhook)

  """
  @spec delete_webhook(String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_webhook(org, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, hook_id: hook_id],
      call: {GitHub.Orgs, :delete_webhook},
      url: "/orgs/#{org}/hooks/#{hook_id}",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Enable or disable a security feature for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#enable-or-disable-security-product-on-all-org-repos)

  """
  @spec enable_or_disable_security_product_on_all_org_repos(
          String.t(),
          String.t(),
          String.t(),
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def enable_or_disable_security_product_on_all_org_repos(
        org,
        security_product,
        enablement,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, security_product: security_product, enablement: enablement],
      call: {GitHub.Orgs, :enable_or_disable_security_product_on_all_org_repos},
      url: "/orgs/#{org}/#{security_product}/#{enablement}",
      method: :post,
      response: [{204, nil}, {422, nil}],
      opts: opts
    })
  end

  @doc """
  Get an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#get-an-organization)

  """
  @spec get(String.t(), keyword) :: {:ok, GitHub.Organization.full()} | {:error, GitHub.Error.t()}
  def get(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :get},
      url: "/orgs/#{org}",
      method: :get,
      response: [{200, {GitHub.Organization, :full}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an organization membership for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#get-an-organization-membership-for-the-authenticated-user)

  """
  @spec get_membership_for_authenticated_user(String.t(), keyword) ::
          {:ok, GitHub.OrgMembership.t()} | {:error, GitHub.Error.t()}
  def get_membership_for_authenticated_user(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :get_membership_for_authenticated_user},
      url: "/user/memberships/orgs/#{org}",
      method: :get,
      response: [
        {200, {GitHub.OrgMembership, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get organization membership for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#get-organization-membership-for-a-user)

  """
  @spec get_membership_for_user(String.t(), String.t(), keyword) ::
          {:ok, GitHub.OrgMembership.t()} | {:error, GitHub.Error.t()}
  def get_membership_for_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :get_membership_for_user},
      url: "/orgs/#{org}/memberships/#{username}",
      method: :get,
      response: [
        {200, {GitHub.OrgMembership, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get an organization webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#get-an-organization-webhook)

  """
  @spec get_webhook(String.t(), integer, keyword) ::
          {:ok, GitHub.OrgHook.t()} | {:error, GitHub.Error.t()}
  def get_webhook(org, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, hook_id: hook_id],
      call: {GitHub.Orgs, :get_webhook},
      url: "/orgs/#{org}/hooks/#{hook_id}",
      method: :get,
      response: [{200, {GitHub.OrgHook, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a webhook configuration for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#get-a-webhook-configuration-for-an-organization)

  """
  @spec get_webhook_config_for_org(String.t(), integer, keyword) ::
          {:ok, GitHub.Webhook.Config.t()} | {:error, GitHub.Error.t()}
  def get_webhook_config_for_org(org, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, hook_id: hook_id],
      call: {GitHub.Orgs, :get_webhook_config_for_org},
      url: "/orgs/#{org}/hooks/#{hook_id}/config",
      method: :get,
      response: [{200, {GitHub.Webhook.Config, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a webhook delivery for an organization webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#get-a-webhook-delivery-for-an-organization-webhook)

  """
  @spec get_webhook_delivery(String.t(), integer, integer, keyword) ::
          {:ok, GitHub.Hook.Delivery.t()} | {:error, GitHub.Error.t()}
  def get_webhook_delivery(org, hook_id, delivery_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, hook_id: hook_id, delivery_id: delivery_id],
      call: {GitHub.Orgs, :get_webhook_delivery},
      url: "/orgs/#{org}/hooks/#{hook_id}/deliveries/#{delivery_id}",
      method: :get,
      response: [
        {200, {GitHub.Hook.Delivery, :t}},
        {400, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organizations

  ## Options

    * `since` (integer): An organization ID. Only return organizations with an ID greater than this ID.
    * `per_page` (integer): The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-organizations)

  """
  @spec list(keyword) :: {:ok, [GitHub.Organization.simple()]} | {:error, GitHub.Error.t()}
  def list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:per_page, :since])

    client.request(%{
      call: {GitHub.Orgs, :list},
      url: "/organizations",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Organization, :simple}}}, {304, nil}],
      opts: opts
    })
  end

  @doc """
  List app installations for an organization

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-app-installations-for-an-organization)

  """
  @spec list_app_installations(String.t(), keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_app_installations(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :list_app_installations},
      url: "/orgs/#{org}/installations",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List users blocked by an organization

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-users-blocked-by-an-organization)

  """
  @spec list_blocked_users(String.t(), keyword) ::
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.Error.t()}
  def list_blocked_users(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :list_blocked_users},
      url: "/orgs/#{org}/blocks",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}],
      opts: opts
    })
  end

  @doc """
  List failed organization invitations

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-failed-organization-invitations)

  """
  @spec list_failed_invitations(String.t(), keyword) ::
          {:ok, [GitHub.Organization.Invitation.t()]} | {:error, GitHub.Error.t()}
  def list_failed_invitations(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :list_failed_invitations},
      url: "/orgs/#{org}/failed_invitations",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Organization.Invitation, :t}}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organizations for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-organizations-for-the-authenticated-user)

  """
  @spec list_for_authenticated_user(keyword) ::
          {:ok, [GitHub.Organization.simple()]} | {:error, GitHub.Error.t()}
  def list_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      call: {GitHub.Orgs, :list_for_authenticated_user},
      url: "/user/orgs",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Organization, :simple}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organizations for a user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-organizations-for-a-user)

  """
  @spec list_for_user(String.t(), keyword) ::
          {:ok, [GitHub.Organization.simple()]} | {:error, GitHub.Error.t()}
  def list_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [username: username],
      call: {GitHub.Orgs, :list_for_user},
      url: "/users/#{username}/orgs",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Organization, :simple}}}],
      opts: opts
    })
  end

  @doc """
  List organization invitation teams

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-organization-invitation-teams)

  """
  @spec list_invitation_teams(String.t(), integer, keyword) ::
          {:ok, [GitHub.Team.t()]} | {:error, GitHub.Error.t()}
  def list_invitation_teams(org, invitation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, invitation_id: invitation_id],
      call: {GitHub.Orgs, :list_invitation_teams},
      url: "/orgs/#{org}/invitations/#{invitation_id}/teams",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Team, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List organization members

  ## Options

    * `filter` (String.t()): Filter members returned in the list. `2fa_disabled` means that only members without [two-factor authentication](https://github.com/blog/1614-two-factor-authentication) enabled will be returned. This options is only available for organization owners.
    * `role` (String.t()): Filter members returned by their role.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-organization-members)

  """
  @spec list_members(String.t(), keyword) ::
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.Error.t()}
  def list_members(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:filter, :page, :per_page, :role])

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :list_members},
      url: "/orgs/#{org}/members",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  List organization memberships for the authenticated user

  ## Options

    * `state` (String.t()): Indicates the state of the memberships to return. If not specified, the API returns both active and pending memberships.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-organization-memberships-for-the-authenticated-user)

  """
  @spec list_memberships_for_authenticated_user(keyword) ::
          {:ok, [GitHub.OrgMembership.t()]} | {:error, GitHub.Error.t()}
  def list_memberships_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :state])

    client.request(%{
      call: {GitHub.Orgs, :list_memberships_for_authenticated_user},
      url: "/user/memberships/orgs",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.OrgMembership, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List outside collaborators for an organization

  ## Options

    * `filter` (String.t()): Filter the list of outside collaborators. `2fa_disabled` means that only outside collaborators without [two-factor authentication](https://github.com/blog/1614-two-factor-authentication) enabled will be returned.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-outside-collaborators-for-an-organization)

  """
  @spec list_outside_collaborators(String.t(), keyword) ::
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.Error.t()}
  def list_outside_collaborators(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:filter, :page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :list_outside_collaborators},
      url: "/orgs/#{org}/outside_collaborators",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}],
      opts: opts
    })
  end

  @doc """
  List repositories a fine-grained personal access token has access to

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#list-repositories-a-fine-grained-personal-access-token-has-access-to)

  """
  @spec list_pat_grant_repositories(String.t(), integer, keyword) ::
          {:ok, [GitHub.Repository.minimal()]} | {:error, GitHub.Error.t()}
  def list_pat_grant_repositories(org, pat_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, pat_id: pat_id],
      call: {GitHub.Orgs, :list_pat_grant_repositories},
      url: "/organizations/#{org}/personal-access-tokens/#{pat_id}/repositories",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Repository, :minimal}}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repositories requested to be accessed by a fine-grained personal access token

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#list-repositories-requested-to-be-accessed-by-a-fine-grained-personal-access-token)

  """
  @spec list_pat_grant_request_repositories(String.t(), integer, keyword) ::
          {:ok, [GitHub.Repository.minimal()]} | {:error, GitHub.Error.t()}
  def list_pat_grant_request_repositories(org, pat_request_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, pat_request_id: pat_request_id],
      call: {GitHub.Orgs, :list_pat_grant_request_repositories},
      url: "/organizations/#{org}/personal-access-token-requests/#{pat_request_id}/repositories",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Repository, :minimal}}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List requests to access organization resources with fine-grained personal access tokens

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `sort` (String.t()): The property by which to sort the results.
    * `direction` (String.t()): The direction to sort the results by.
    * `owner` ([String.t()]): A list of owner usernames to use to filter the results.
    * `repository` (String.t()): The name of the repository to use to filter the results.
    * `permission` (String.t()): The permission to use to filter the results.
    * `last_used_before` (String.t()): Only show fine-grained personal access tokens used before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `last_used_after` (String.t()): Only show fine-grained personal access tokens used after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#list-requests-to-access-organization-resources-with-fine-grained-personal-access-tokens)

  """
  @spec list_pat_grant_requests(String.t(), keyword) ::
          {:ok, [GitHub.Organization.ProgrammaticAccessGrant.Request.t()]}
          | {:error, GitHub.Error.t()}
  def list_pat_grant_requests(org, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :direction,
        :last_used_after,
        :last_used_before,
        :owner,
        :page,
        :per_page,
        :permission,
        :repository,
        :sort
      ])

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :list_pat_grant_requests},
      url: "/organizations/#{org}/personal-access-token-requests",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Organization.ProgrammaticAccessGrant.Request, :t}}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List fine-grained personal access tokens with access to organization resources

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `sort` (String.t()): The property by which to sort the results.
    * `direction` (String.t()): The direction to sort the results by.
    * `owner` ([String.t()]): A list of owner usernames to use to filter the results.
    * `repository` (String.t()): The name of the repository to use to filter the results.
    * `permission` (String.t()): The permission to use to filter the results.
    * `last_used_before` (String.t()): Only show fine-grained personal access tokens used before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `last_used_after` (String.t()): Only show fine-grained personal access tokens used after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#list-fine-grained-personal-access-tokens-with-access-to-organization-resources)

  """
  @spec list_pat_grants(String.t(), keyword) ::
          {:ok, [GitHub.Organization.ProgrammaticAccessGrant.t()]} | {:error, GitHub.Error.t()}
  def list_pat_grants(org, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :direction,
        :last_used_after,
        :last_used_before,
        :owner,
        :page,
        :per_page,
        :permission,
        :repository,
        :sort
      ])

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :list_pat_grants},
      url: "/organizations/#{org}/personal-access-tokens",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Organization.ProgrammaticAccessGrant, :t}}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List pending organization invitations

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `role` (String.t()): Filter invitations by their member role.
    * `invitation_source` (String.t()): Filter invitations by their invitation source.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-pending-organization-invitations)

  """
  @spec list_pending_invitations(String.t(), keyword) ::
          {:ok, [GitHub.Organization.Invitation.t()]} | {:error, GitHub.Error.t()}
  def list_pending_invitations(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:invitation_source, :page, :per_page, :role])

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :list_pending_invitations},
      url: "/orgs/#{org}/invitations",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Organization.Invitation, :t}}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List public organization members

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-public-organization-members)

  """
  @spec list_public_members(String.t(), keyword) ::
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.Error.t()}
  def list_public_members(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :list_public_members},
      url: "/orgs/#{org}/public_members",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}],
      opts: opts
    })
  end

  @doc """
  List security manager teams

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-security-manager-teams)

  """
  @spec list_security_manager_teams(String.t(), keyword) ::
          {:ok, [GitHub.Team.simple()]} | {:error, GitHub.Error.t()}
  def list_security_manager_teams(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :list_security_manager_teams},
      url: "/orgs/#{org}/security-managers",
      method: :get,
      response: [{200, {:array, {GitHub.Team, :simple}}}],
      opts: opts
    })
  end

  @doc """
  List deliveries for an organization webhook

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `cursor` (String.t()): Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the `link` header for the next and previous page cursors.
    * `redelivery` (boolean): 

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-deliveries-for-an-organization-webhook)

  """
  @spec list_webhook_deliveries(String.t(), integer, keyword) ::
          {:ok, [GitHub.Hook.DeliveryItem.t()]} | {:error, GitHub.Error.t()}
  def list_webhook_deliveries(org, hook_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :per_page, :redelivery])

    client.request(%{
      args: [org: org, hook_id: hook_id],
      call: {GitHub.Orgs, :list_webhook_deliveries},
      url: "/orgs/#{org}/hooks/#{hook_id}/deliveries",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Hook.DeliveryItem, :t}}},
        {400, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organization webhooks

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-organization-webhooks)

  """
  @spec list_webhooks(String.t(), keyword) ::
          {:ok, [GitHub.OrgHook.t()]} | {:error, GitHub.Error.t()}
  def list_webhooks(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Orgs, :list_webhooks},
      url: "/orgs/#{org}/hooks",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.OrgHook, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Ping an organization webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#ping-an-organization-webhook)

  """
  @spec ping_webhook(String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def ping_webhook(org, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, hook_id: hook_id],
      call: {GitHub.Orgs, :ping_webhook},
      url: "/orgs/#{org}/hooks/#{hook_id}/pings",
      method: :post,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Redeliver a delivery for an organization webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#redeliver-a-delivery-for-an-organization-webhook)

  """
  @spec redeliver_webhook_delivery(String.t(), integer, integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def redeliver_webhook_delivery(org, hook_id, delivery_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, hook_id: hook_id, delivery_id: delivery_id],
      call: {GitHub.Orgs, :redeliver_webhook_delivery},
      url: "/orgs/#{org}/hooks/#{hook_id}/deliveries/#{delivery_id}/attempts",
      method: :post,
      response: [{202, :map}, {400, {GitHub.BasicError, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove an organization member

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#remove-an-organization-member)

  """
  @spec remove_member(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def remove_member(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :remove_member},
      url: "/orgs/#{org}/members/#{username}",
      method: :delete,
      response: [{204, nil}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove organization membership for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#remove-organization-membership-for-a-user)

  """
  @spec remove_membership_for_user(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_membership_for_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :remove_membership_for_user},
      url: "/orgs/#{org}/memberships/#{username}",
      method: :delete,
      response: [{204, nil}, {403, {GitHub.BasicError, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove outside collaborator from an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#remove-outside-collaborator-from-an-organization)

  """
  @spec remove_outside_collaborator(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_outside_collaborator(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :remove_outside_collaborator},
      url: "/orgs/#{org}/outside_collaborators/#{username}",
      method: :delete,
      response: [{204, nil}, {422, :map}],
      opts: opts
    })
  end

  @doc """
  Remove public organization membership for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#remove-public-organization-membership-for-the-authenticated-user)

  """
  @spec remove_public_membership_for_authenticated_user(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_public_membership_for_authenticated_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :remove_public_membership_for_authenticated_user},
      url: "/orgs/#{org}/public_members/#{username}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Remove a security manager team

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#remove-a-security-manager-team)

  """
  @spec remove_security_manager_team(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_security_manager_team(org, team_slug, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug],
      call: {GitHub.Orgs, :remove_security_manager_team},
      url: "/orgs/#{org}/security-managers/teams/#{team_slug}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Review a request to access organization resources with a fine-grained personal access token

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#review-a-request-to-access-organization-resources-with-a-fine-grained-personal-access-token)

  """
  @spec review_pat_grant_request(String.t(), integer, map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def review_pat_grant_request(org, pat_request_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, pat_request_id: pat_request_id, body: body],
      call: {GitHub.Orgs, :review_pat_grant_request},
      url: "/organizations/#{org}/personal-access-token-requests/#{pat_request_id}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {204, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Review requests to access organization resources with fine-grained personal access tokens

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#review-requests-to-access-organization-resources-with-a-fine-grained-personal-access-token)

  """
  @spec review_pat_grant_requests_in_bulk(String.t(), map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def review_pat_grant_requests_in_bulk(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Orgs, :review_pat_grant_requests_in_bulk},
      url: "/organizations/#{org}/personal-access-token-requests",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {202, :map},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Set organization membership for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#set-organization-membership-for-a-user)

  """
  @spec set_membership_for_user(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.OrgMembership.t()} | {:error, GitHub.Error.t()}
  def set_membership_for_user(org, username, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username, body: body],
      call: {GitHub.Orgs, :set_membership_for_user},
      url: "/orgs/#{org}/memberships/#{username}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.OrgMembership, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Set public organization membership for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#set-public-organization-membership-for-the-authenticated-user)

  """
  @spec set_public_membership_for_authenticated_user(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_public_membership_for_authenticated_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :set_public_membership_for_authenticated_user},
      url: "/orgs/#{org}/public_members/#{username}",
      method: :put,
      response: [{204, nil}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Unblock a user from an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#unblock-a-user-from-an-organization)

  """
  @spec unblock_user(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def unblock_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :unblock_user},
      url: "/orgs/#{org}/blocks/#{username}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Update an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#update-an-organization)

  """
  @spec update(String.t(), map, keyword) ::
          {:ok, GitHub.Organization.full()} | {:error, GitHub.Error.t()}
  def update(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Orgs, :update},
      url: "/orgs/#{org}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Organization, :full}},
        {409, {GitHub.BasicError, :t}},
        {422, {:union, [{GitHub.ValidationError, :t}, {GitHub.ValidationError, :simple}]}}
      ],
      opts: opts
    })
  end

  @doc """
  Update an organization membership for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#update-an-organization-membership-for-the-authenticated-user)

  """
  @spec update_membership_for_authenticated_user(String.t(), map, keyword) ::
          {:ok, GitHub.OrgMembership.t()} | {:error, GitHub.Error.t()}
  def update_membership_for_authenticated_user(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Orgs, :update_membership_for_authenticated_user},
      url: "/user/memberships/orgs/#{org}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.OrgMembership, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update the access a fine-grained personal access token has to organization resources

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#update-the-access-a-fine-grained-personal-access-token-has-to-organization-resources)

  """
  @spec update_pat_access(String.t(), integer, map, keyword) :: :ok | {:error, GitHub.Error.t()}
  def update_pat_access(org, pat_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, pat_id: pat_id, body: body],
      call: {GitHub.Orgs, :update_pat_access},
      url: "/organizations/#{org}/personal-access-tokens/#{pat_id}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {204, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update the access to organization resources via fine-grained personal access tokens

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#update-the-access-to-organization-resources-via-fine-grained-personal-access-tokens)

  """
  @spec update_pat_accesses(String.t(), map, keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def update_pat_accesses(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Orgs, :update_pat_accesses},
      url: "/organizations/#{org}/personal-access-tokens",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {202, :map},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update an organization webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#update-an-organization-webhook)

  """
  @spec update_webhook(String.t(), integer, map, keyword) ::
          {:ok, GitHub.OrgHook.t()} | {:error, GitHub.Error.t()}
  def update_webhook(org, hook_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, hook_id: hook_id, body: body],
      call: {GitHub.Orgs, :update_webhook},
      url: "/orgs/#{org}/hooks/#{hook_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.OrgHook, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a webhook configuration for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#update-a-webhook-configuration-for-an-organization)

  """
  @spec update_webhook_config_for_org(String.t(), integer, map, keyword) ::
          {:ok, GitHub.Webhook.Config.t()} | {:error, GitHub.Error.t()}
  def update_webhook_config_for_org(org, hook_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, hook_id: hook_id, body: body],
      call: {GitHub.Orgs, :update_webhook_config_for_org},
      url: "/orgs/#{org}/hooks/#{hook_id}/config",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Webhook.Config, :t}}],
      opts: opts
    })
  end
end
