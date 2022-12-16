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
  @spec add_security_manager_team(String.t(), String.t(), keyword) :: :ok | :error
  def add_security_manager_team(org, team_slug, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
  @spec block_user(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.ValidationError.t()}
  def block_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
  @spec cancel_invitation(String.t(), integer, keyword) ::
          :ok | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def cancel_invitation(org, invitation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
  @spec check_blocked_user(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def check_blocked_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
  @spec check_membership_for_user(String.t(), String.t(), keyword) :: :ok | :error
  def check_membership_for_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
  @spec check_public_membership_for_user(String.t(), String.t(), keyword) :: :ok | :error
  def check_public_membership_for_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
          {:ok, map} | {:error, GitHub.BasicError.t()}
  def convert_member_to_outside_collaborator(org, username, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/outside_collaborators/#{username}",
      body: body,
      method: :put,
      response: [{202, :map}, {204, nil}, {403, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a custom role

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#create-a-custom-role)

  """
  @spec create_custom_role(String.t(), map, keyword) ::
          {:ok, GitHub.Organization.CustomRepositoryRole.t()}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def create_custom_role(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/custom_roles",
      body: body,
      method: :post,
      response: [
        {201, {GitHub.Organization.CustomRepositoryRole, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create an organization invitation

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#create-an-organization-invitation)

  """
  @spec create_invitation(String.t(), map, keyword) ::
          {:ok, GitHub.Organization.Invitation.t()}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def create_invitation(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/invitations",
      body: body,
      method: :post,
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
          {:ok, GitHub.OrgHook.t()} | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def create_webhook(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/hooks",
      body: body,
      method: :post,
      response: [
        {201, {GitHub.OrgHook, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a custom role

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#delete-a-custom-role)

  """
  @spec delete_custom_role(String.t(), integer, keyword) :: :ok | :error
  def delete_custom_role(org, role_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/custom_roles/#{role_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete an organization webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#delete-an-organization-webhook)

  """
  @spec delete_webhook(String.t(), integer, keyword) :: :ok | {:error, GitHub.BasicError.t()}
  def delete_webhook(org, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
        ) :: :ok | :error
  def enable_or_disable_security_product_on_all_org_repos(
        org,
        security_product,
        enablement,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
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
  @spec get(String.t(), keyword) ::
          {:ok, GitHub.Organization.Full.t()} | {:error, GitHub.BasicError.t()}
  def get(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}",
      method: :get,
      response: [{200, {GitHub.Organization.Full, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a custom role

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs/#get-a-custom-role)

  """
  @spec get_custom_role(String.t(), integer, keyword) ::
          {:ok, GitHub.Organization.CustomRepositoryRole.t()} | {:error, GitHub.BasicError.t()}
  def get_custom_role(org, role_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/custom_roles/#{role_id}",
      method: :get,
      response: [
        {200, {GitHub.Organization.CustomRepositoryRole, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get an organization membership for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#get-an-organization-membership-for-the-authenticated-user)

  """
  @spec get_membership_for_authenticated_user(String.t(), keyword) ::
          {:ok, GitHub.OrgMembership.t()} | {:error, GitHub.BasicError.t()}
  def get_membership_for_authenticated_user(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
          {:ok, GitHub.OrgMembership.t()} | {:error, GitHub.BasicError.t()}
  def get_membership_for_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
          {:ok, GitHub.OrgHook.t()} | {:error, GitHub.BasicError.t()}
  def get_webhook(org, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
          {:ok, GitHub.Webhook.Config.t()} | :error
  def get_webhook_config_for_org(org, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
          {:ok, GitHub.Hook.Delivery.t()}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def get_webhook_delivery(org, hook_id, delivery_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
  @spec list(keyword) :: {:ok, [GitHub.Organization.simple()]} | :error
  def list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:per_page, :since])

    client.request(%{
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
  @spec list_app_installations(String.t(), keyword) :: {:ok, map} | :error
  def list_app_installations(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
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
  @spec list_blocked_users(String.t(), keyword) :: {:ok, [GitHub.User.simple()]} | :error
  def list_blocked_users(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/orgs/#{org}/blocks",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}],
      opts: opts
    })
  end

  @doc """
  List custom repository roles in an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-custom-repository-roles-in-an-organization)

  """
  @spec list_custom_roles(String.t(), keyword) :: {:ok, map} | :error
  def list_custom_roles(organization_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/organizations/#{organization_id}/custom_roles",
      method: :get,
      response: [{200, :map}],
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
          {:ok, [GitHub.Organization.Invitation.t()]} | {:error, GitHub.BasicError.t()}
  def list_failed_invitations(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
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
  List fine-grained permissions for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-fine-grained-permissions-for-an-organization)

  """
  @spec list_fine_grained_permissions(String.t(), keyword) ::
          {:ok, [GitHub.Organization.FineGrainedPermission.t()]} | :error
  def list_fine_grained_permissions(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/fine_grained_permissions",
      method: :get,
      response: [{200, {:array, {GitHub.Organization.FineGrainedPermission, :t}}}],
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
          {:ok, [GitHub.Organization.simple()]} | {:error, GitHub.BasicError.t()}
  def list_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
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
  @spec list_for_user(String.t(), keyword) :: {:ok, [GitHub.Organization.simple()]} | :error
  def list_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
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
          {:ok, [GitHub.Team.t()]} | {:error, GitHub.BasicError.t()}
  def list_invitation_teams(org, invitation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
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
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.ValidationError.t()}
  def list_members(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:filter, :page, :per_page, :role])

    client.request(%{
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
          {:ok, [GitHub.OrgMembership.t()]}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def list_memberships_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :state])

    client.request(%{
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
  @spec list_outside_collaborators(String.t(), keyword) :: {:ok, [GitHub.User.simple()]} | :error
  def list_outside_collaborators(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:filter, :page, :per_page])

    client.request(%{
      url: "/orgs/#{org}/outside_collaborators",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}],
      opts: opts
    })
  end

  @doc """
  List pending organization invitations

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#list-pending-organization-invitations)

  """
  @spec list_pending_invitations(String.t(), keyword) ::
          {:ok, [GitHub.Organization.Invitation.t()]} | {:error, GitHub.BasicError.t()}
  def list_pending_invitations(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
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
  @spec list_public_members(String.t(), keyword) :: {:ok, [GitHub.User.simple()]} | :error
  def list_public_members(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
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
  @spec list_security_manager_teams(String.t(), keyword) :: {:ok, [GitHub.Team.simple()]} | :error
  def list_security_manager_teams(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
          {:ok, [GitHub.Hook.DeliveryItem.t()]}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def list_webhook_deliveries(org, hook_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :per_page, :redelivery])

    client.request(%{
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
          {:ok, [GitHub.OrgHook.t()]} | {:error, GitHub.BasicError.t()}
  def list_webhooks(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
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
  @spec ping_webhook(String.t(), integer, keyword) :: :ok | {:error, GitHub.BasicError.t()}
  def ping_webhook(org, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
          {:ok, map} | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def redeliver_webhook_delivery(org, hook_id, delivery_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
  @spec remove_member(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.BasicError.t()}
  def remove_member(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
          :ok | {:error, GitHub.BasicError.t()}
  def remove_membership_for_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
  @spec remove_outside_collaborator(String.t(), String.t(), keyword) :: :ok | {:error, map}
  def remove_outside_collaborator(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
          :ok | :error
  def remove_public_membership_for_authenticated_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
  @spec remove_security_manager_team(String.t(), String.t(), keyword) :: :ok | :error
  def remove_security_manager_team(org, team_slug, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/security-managers/teams/#{team_slug}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set organization membership for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#set-organization-membership-for-a-user)

  """
  @spec set_membership_for_user(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.OrgMembership.t()}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def set_membership_for_user(org, username, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/memberships/#{username}",
      body: body,
      method: :put,
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
          :ok | {:error, GitHub.BasicError.t()}
  def set_public_membership_for_authenticated_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
  @spec unblock_user(String.t(), String.t(), keyword) :: :ok | :error
  def unblock_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
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
          {:ok, GitHub.Organization.Full.t()}
          | {:error,
             GitHub.BasicError.t() | GitHub.ValidationError.simple() | GitHub.ValidationError.t()}
  def update(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}",
      body: body,
      method: :patch,
      response: [
        {200, {GitHub.Organization.Full, :t}},
        {409, {GitHub.BasicError, :t}},
        {422, {:union, [{GitHub.ValidationError, :t}, {GitHub.ValidationError, :simple}]}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a custom role

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#update-a-custom-role)

  """
  @spec update_custom_role(String.t(), integer, map, keyword) ::
          {:ok, GitHub.Organization.CustomRepositoryRole.t()}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def update_custom_role(org, role_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/custom_roles/#{role_id}",
      body: body,
      method: :patch,
      response: [
        {200, {GitHub.Organization.CustomRepositoryRole, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
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
          {:ok, GitHub.OrgMembership.t()}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def update_membership_for_authenticated_user(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/memberships/orgs/#{org}",
      body: body,
      method: :patch,
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
  Update an organization webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/orgs#update-an-organization-webhook)

  """
  @spec update_webhook(String.t(), integer, map, keyword) ::
          {:ok, GitHub.OrgHook.t()} | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def update_webhook(org, hook_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/hooks/#{hook_id}",
      body: body,
      method: :patch,
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
          {:ok, GitHub.Webhook.Config.t()} | :error
  def update_webhook_config_for_org(org, hook_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/hooks/#{hook_id}/config",
      body: body,
      method: :patch,
      response: [{200, {GitHub.Webhook.Config, :t}}],
      opts: opts
    })
  end
end
