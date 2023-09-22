defmodule GitHub.Orgs do
  @moduledoc """
  Provides API endpoints related to orgs
  """

  @default_client GitHub.Client

  @doc """
  Add a security manager team

  Adds a team as a security manager for an organization. For more information, see "[Managing security for an organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization) for an organization."

  To use this endpoint, you must be an administrator for the organization, and you must use an access token with the `write:org` scope.

  GitHub Apps must have the `administration` organization read-write permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/security-managers#add-a-security-manager-team)

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
      response: [{204, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Block a user from an organization

  Blocks the given user on behalf of the specified organization and returns a 204. If the organization cannot block the given user a 422 is returned.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/blocking#block-a-user-from-an-organization)

  """
  @spec block_user(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def block_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :block_user},
      url: "/orgs/#{org}/blocks/#{username}",
      method: :put,
      response: [{204, :null}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Cancel an organization invitation

  Cancel an organization invitation. In order to cancel an organization invitation, the authenticated user must be an organization owner.

  This endpoint triggers [notifications](https://docs.github.com/github/managing-subscriptions-and-notifications-on-github/about-notifications).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#cancel-an-organization-invitation)

  """
  @spec cancel_invitation(String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def cancel_invitation(org, invitation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, invitation_id: invitation_id],
      call: {GitHub.Orgs, :cancel_invitation},
      url: "/orgs/#{org}/invitations/#{invitation_id}",
      method: :delete,
      response: [
        {204, :null},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Check if a user is blocked by an organization

  Returns a 204 if the given user is blocked by the given organization. Returns a 404 if the organization is not blocking the user, or if the user account has been identified as spam by GitHub.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/blocking#check-if-a-user-is-blocked-by-an-organization)

  """
  @spec check_blocked_user(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def check_blocked_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :check_blocked_user},
      url: "/orgs/#{org}/blocks/#{username}",
      method: :get,
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Check organization membership for a user

  Check if a user is, publicly or privately, a member of the organization.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#check-organization-membership-for-a-user)

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
      response: [{204, :null}, {302, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Check public organization membership for a user

  Check if the provided user is a public member of the organization.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#check-public-organization-membership-for-a-user)

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
      response: [{204, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Convert an organization member to outside collaborator

  When an organization member is converted to an outside collaborator, they'll only have access to the repositories that their current team membership allows. The user will no longer be a member of the organization. For more information, see "[Converting an organization member to an outside collaborator](https://docs.github.com/articles/converting-an-organization-member-to-an-outside-collaborator/)". Converting an organization member to an outside collaborator may be restricted by enterprise administrators. For more information, see "[Enforcing repository management policies in your enterprise](https://docs.github.com/admin/policies/enforcing-policies-for-your-enterprise/enforcing-repository-management-policies-in-your-enterprise#enforcing-a-policy-for-inviting-outside-collaborators-to-repositories)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/outside-collaborators#convert-an-organization-member-to-outside-collaborator)

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
      response: [{202, :map}, {204, :null}, {403, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create an organization invitation

  Invite people to an organization by using their GitHub user ID or their email address. In order to create invitations in an organization, the authenticated user must be an organization owner.

  This endpoint triggers [notifications](https://docs.github.com/github/managing-subscriptions-and-notifications-on-github/about-notifications). Creating content too quickly using this endpoint may result in secondary rate limiting. See "[Secondary rate limits](https://docs.github.com/rest/overview/resources-in-the-rest-api#secondary-rate-limits)" and "[Dealing with secondary rate limits](https://docs.github.com/rest/guides/best-practices-for-integrators#dealing-with-secondary-rate-limits)" for details.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#create-an-organization-invitation)

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

  Here's how you can create a hook that posts payloads in JSON format:

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/webhooks#create-an-organization-webhook)

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

  Deletes an organization and all its repositories.

  The organization login will be unavailable for 90 days after deletion.

  Please review the Terms of Service regarding account deletion before using this endpoint:

  https://docs.github.com/site-policy/github-terms/github-terms-of-service

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#delete-an-organization)

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

    * [API method documentation](https://docs.github.com/rest/orgs/webhooks#delete-an-organization-webhook)

  """
  @spec delete_webhook(String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_webhook(org, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, hook_id: hook_id],
      call: {GitHub.Orgs, :delete_webhook},
      url: "/orgs/#{org}/hooks/#{hook_id}",
      method: :delete,
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Enable or disable a security feature for an organization

  Enables or disables the specified security feature for all eligible repositories in an organization.

  To use this endpoint, you must be an organization owner or be member of a team with the security manager role.
  A token with the 'write:org' scope is also required.

  GitHub Apps must have the `organization_administration:write` permission to use this endpoint.

  For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#enable-or-disable-a-security-feature-for-an-organization)

  """
  @spec enable_or_disable_security_product_on_all_org_repos(
          String.t(),
          String.t(),
          String.t(),
          map,
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def enable_or_disable_security_product_on_all_org_repos(
        org,
        security_product,
        enablement,
        body,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, security_product: security_product, enablement: enablement, body: body],
      call: {GitHub.Orgs, :enable_or_disable_security_product_on_all_org_repos},
      url: "/orgs/#{org}/#{security_product}/#{enablement}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{204, :null}, {422, :null}],
      opts: opts
    })
  end

  @doc """
  Get an organization

  To see many of the organization response values, you need to be an authenticated organization owner with the `admin:org` scope. When the value of `two_factor_requirement_enabled` is `true`, the organization requires all members, billing managers, and outside collaborators to enable [two-factor authentication](https://docs.github.com/articles/securing-your-account-with-two-factor-authentication-2fa/).

  GitHub Apps with the `Organization plan` permission can use this endpoint to retrieve information about an organization's GitHub plan. See "[Authenticating with GitHub Apps](https://docs.github.com/apps/building-github-apps/authenticating-with-github-apps/)" for details. For an example response, see 'Response with GitHub plan information' below."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#get-an-organization)

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

  If the authenticated user is an active or pending member of the organization, this endpoint will return the user's membership. If the authenticated user is not affiliated with the organization, a `404` is returned. This endpoint will return a `403` if the request is made by a GitHub App that is blocked by the organization.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#get-an-organization-membership-for-the-authenticated-user)

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

  In order to get a user's membership with an organization, the authenticated user must be an organization member. The `state` parameter in the response can be used to identify the user's membership status.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#get-organization-membership-for-a-user)

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

  Returns a webhook configured in an organization. To get only the webhook `config` properties, see "[Get a webhook configuration for an organization](/rest/orgs/webhooks#get-a-webhook-configuration-for-an-organization)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/webhooks#get-an-organization-webhook)

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

  Returns the webhook configuration for an organization. To get more information about the webhook, including the `active` state and `events`, use "[Get an organization webhook ](/rest/orgs/webhooks#get-an-organization-webhook)."

  Access tokens must have the `admin:org_hook` scope, and GitHub Apps must have the `organization_hooks:read` permission.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/webhooks#get-a-webhook-configuration-for-an-organization)

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

  Returns a delivery for a webhook configured in an organization.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/webhooks#get-a-webhook-delivery-for-an-organization-webhook)

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
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organizations

  Lists all organizations, in the order that they were created on GitHub.

  **Note:** Pagination is powered exclusively by the `since` parameter. Use the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers) to get the URL for the next page of organizations.

  ## Options

    * `since`: An organization ID. Only return organizations with an ID greater than this ID.
    * `per_page`: The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#list-organizations)

  """
  @spec list(keyword) :: {:ok, [GitHub.Organization.simple()]} | {:error, GitHub.Error.t()}
  def list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:per_page, :since])

    client.request(%{
      args: [],
      call: {GitHub.Orgs, :list},
      url: "/organizations",
      method: :get,
      query: query,
      response: [{200, [{GitHub.Organization, :simple}]}, {304, :null}],
      opts: opts
    })
  end

  @doc """
  List app installations for an organization

  Lists all GitHub Apps in an organization. The installation count includes all GitHub Apps installed on repositories in the organization. You must be an organization owner with `admin:read` scope to use this endpoint.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#list-app-installations-for-an-organization)

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

  List the users blocked by an organization.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/blocking#list-users-blocked-by-an-organization)

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
      response: [{200, [{GitHub.User, :simple}]}],
      opts: opts
    })
  end

  @doc """
  List failed organization invitations

  The return hash contains `failed_at` and `failed_reason` fields which represent the time at which the invitation failed and the reason for the failure.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#list-failed-organization-invitations)

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
      response: [{200, [{GitHub.Organization.Invitation, :t}]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List organizations for the authenticated user

  List organizations for the authenticated user.

  **OAuth scope requirements**

  This only lists organizations that your authorization allows you to operate on in some way (e.g., you can list teams with `read:org` scope, you can publicize your organization membership with `user` scope, etc.). Therefore, this API requires at least `user` or `read:org` scope. OAuth requests with insufficient scope receive a `403 Forbidden` response.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#list-organizations-for-the-authenticated-user)

  """
  @spec list_for_authenticated_user(keyword) ::
          {:ok, [GitHub.Organization.simple()]} | {:error, GitHub.Error.t()}
  def list_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [],
      call: {GitHub.Orgs, :list_for_authenticated_user},
      url: "/user/orgs",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Organization, :simple}]},
        {304, :null},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organizations for a user

  List [public organization memberships](https://docs.github.com/articles/publicizing-or-concealing-organization-membership) for the specified user.

  This method only lists _public_ memberships, regardless of authentication. If you need to fetch all of the organization memberships (public and private) for the authenticated user, use the [List organizations for the authenticated user](https://docs.github.com/rest/orgs/orgs#list-organizations-for-the-authenticated-user) API instead.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#list-organizations-for-a-user)

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
      response: [{200, [{GitHub.Organization, :simple}]}],
      opts: opts
    })
  end

  @doc """
  List organization invitation teams

  List all teams associated with an invitation. In order to see invitations in an organization, the authenticated user must be an organization owner.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#list-organization-invitation-teams)

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
      response: [{200, [{GitHub.Team, :t}]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List organization members

  List all users who are members of an organization. If the authenticated user is also a member of this organization then both concealed and public members will be returned.

  ## Options

    * `filter`: Filter members returned in the list. `2fa_disabled` means that only members without [two-factor authentication](https://github.com/blog/1614-two-factor-authentication) enabled will be returned. This options is only available for organization owners.
    * `role`: Filter members returned by their role.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#list-organization-members)

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
      response: [{200, [{GitHub.User, :simple}]}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  List organization memberships for the authenticated user

  Lists all of the authenticated user's organization memberships.

  ## Options

    * `state`: Indicates the state of the memberships to return. If not specified, the API returns both active and pending memberships.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#list-organization-memberships-for-the-authenticated-user)

  """
  @spec list_memberships_for_authenticated_user(keyword) ::
          {:ok, [GitHub.OrgMembership.t()]} | {:error, GitHub.Error.t()}
  def list_memberships_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :state])

    client.request(%{
      args: [],
      call: {GitHub.Orgs, :list_memberships_for_authenticated_user},
      url: "/user/memberships/orgs",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.OrgMembership, :t}]},
        {304, :null},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List outside collaborators for an organization

  List all users who are outside collaborators of an organization.

  ## Options

    * `filter`: Filter the list of outside collaborators. `2fa_disabled` means that only outside collaborators without [two-factor authentication](https://github.com/blog/1614-two-factor-authentication) enabled will be returned.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/outside-collaborators#list-outside-collaborators-for-an-organization)

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
      response: [{200, [{GitHub.User, :simple}]}],
      opts: opts
    })
  end

  @doc """
  List repositories a fine-grained personal access token has access to

  Lists the repositories a fine-grained personal access token has access to. Only GitHub Apps can call this API,
  using the `organization_personal_access_tokens: read` permission.

  **Note**: Fine-grained PATs are in public beta. Related APIs, events, and functionality are subject to change.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/personal-access-tokens#list-repositories-a-fine-grained-personal-access-token-has-access-to)

  """
  @spec list_pat_grant_repositories(String.t(), integer, keyword) ::
          {:ok, [GitHub.Repository.minimal()]} | {:error, GitHub.Error.t()}
  def list_pat_grant_repositories(org, pat_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, pat_id: pat_id],
      call: {GitHub.Orgs, :list_pat_grant_repositories},
      url: "/orgs/#{org}/personal-access-tokens/#{pat_id}/repositories",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Repository, :minimal}]},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repositories requested to be accessed by a fine-grained personal access token

  Lists the repositories a fine-grained personal access token request is requesting access to. Only GitHub Apps can call this API,
  using the `organization_personal_access_token_requests: read` permission.

  **Note**: Fine-grained PATs are in public beta. Related APIs, events, and functionality are subject to change.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/personal-access-tokens#list-repositories-requested-to-be-accessed-by-a-fine-grained-personal-access-token)

  """
  @spec list_pat_grant_request_repositories(String.t(), integer, keyword) ::
          {:ok, [GitHub.Repository.minimal()]} | {:error, GitHub.Error.t()}
  def list_pat_grant_request_repositories(org, pat_request_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, pat_request_id: pat_request_id],
      call: {GitHub.Orgs, :list_pat_grant_request_repositories},
      url: "/orgs/#{org}/personal-access-token-requests/#{pat_request_id}/repositories",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Repository, :minimal}]},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List requests to access organization resources with fine-grained personal access tokens

  Lists requests from organization members to access organization resources with a fine-grained personal access token. Only GitHub Apps can call this API,
  using the `organization_personal_access_token_requests: read` permission.

  **Note**: Fine-grained PATs are in public beta. Related APIs, events, and functionality are subject to change.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.
    * `sort`: The property by which to sort the results.
    * `direction`: The direction to sort the results by.
    * `owner`: A list of owner usernames to use to filter the results.
    * `repository`: The name of the repository to use to filter the results.
    * `permission`: The permission to use to filter the results.
    * `last_used_before`: Only show fine-grained personal access tokens used before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `last_used_after`: Only show fine-grained personal access tokens used after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/personal-access-tokens#list-requests-to-access-organization-resources-with-fine-grained-personal-access-tokens)

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
      url: "/orgs/#{org}/personal-access-token-requests",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Organization.ProgrammaticAccessGrant.Request, :t}]},
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

  Lists approved fine-grained personal access tokens owned by organization members that can access organization resources. Only GitHub Apps can call this API,
  using the `organization_personal_access_tokens: read` permission.

  **Note**: Fine-grained PATs are in public beta. Related APIs, events, and functionality are subject to change.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.
    * `sort`: The property by which to sort the results.
    * `direction`: The direction to sort the results by.
    * `owner`: A list of owner usernames to use to filter the results.
    * `repository`: The name of the repository to use to filter the results.
    * `permission`: The permission to use to filter the results.
    * `last_used_before`: Only show fine-grained personal access tokens used before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `last_used_after`: Only show fine-grained personal access tokens used after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/personal-access-tokens#list-fine-grained-personal-access-tokens-with-access-to-organization-resources)

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
      url: "/orgs/#{org}/personal-access-tokens",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Organization.ProgrammaticAccessGrant, :t}]},
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

  The return hash contains a `role` field which refers to the Organization Invitation role and will be one of the following values: `direct_member`, `admin`, `billing_manager`, or `hiring_manager`. If the invitee is not a GitHub member, the `login` field in the return hash will be `null`.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.
    * `role`: Filter invitations by their member role.
    * `invitation_source`: Filter invitations by their invitation source.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#list-pending-organization-invitations)

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
      response: [{200, [{GitHub.Organization.Invitation, :t}]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List public organization members

  Members of an organization can choose to have their membership publicized or not.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#list-public-organization-members)

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
      response: [{200, [{GitHub.User, :simple}]}],
      opts: opts
    })
  end

  @doc """
  List security manager teams

  Lists teams that are security managers for an organization. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."

  To use this endpoint, you must be an administrator or security manager for the organization, and you must use an access token with the `read:org` scope.

  GitHub Apps must have the `administration` organization read permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/security-managers#list-security-manager-teams)

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
      response: [{200, [{GitHub.Team, :simple}]}],
      opts: opts
    })
  end

  @doc """
  List deliveries for an organization webhook

  Returns a list of webhook deliveries for a webhook configured in an organization.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `cursor`: Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the `link` header for the next and previous page cursors.
    * `redelivery`

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/webhooks#list-deliveries-for-an-organization-webhook)

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
        {200, [{GitHub.Hook.DeliveryItem, :t}]},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organization webhooks

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/webhooks#list-organization-webhooks)

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
      response: [{200, [{GitHub.OrgHook, :t}]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Ping an organization webhook

  This will trigger a [ping event](https://docs.github.com/webhooks/#ping-event) to be sent to the hook.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/webhooks#ping-an-organization-webhook)

  """
  @spec ping_webhook(String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def ping_webhook(org, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, hook_id: hook_id],
      call: {GitHub.Orgs, :ping_webhook},
      url: "/orgs/#{org}/hooks/#{hook_id}/pings",
      method: :post,
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Redeliver a delivery for an organization webhook

  Redeliver a delivery for a webhook configured in an organization.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/webhooks#redeliver-a-delivery-for-an-organization-webhook)

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
      response: [
        {202, :map},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove an organization member

  Removing a user from this list will remove them from all teams and they will no longer have any access to the organization's repositories.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#remove-an-organization-member)

  """
  @spec remove_member(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def remove_member(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :remove_member},
      url: "/orgs/#{org}/members/#{username}",
      method: :delete,
      response: [{204, :null}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove organization membership for a user

  In order to remove a user's membership with an organization, the authenticated user must be an organization owner.

  If the specified user is an active member of the organization, this will remove them from the organization. If the specified user has been invited to the organization, this will cancel their invitation. The specified user will receive an email notification in both cases.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#remove-organization-membership-for-a-user)

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
      response: [{204, :null}, {403, {GitHub.BasicError, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove outside collaborator from an organization

  Removing a user from this list will remove them from all the organization's repositories.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/outside-collaborators#remove-outside-collaborator-from-an-organization)

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
      response: [{204, :null}, {422, :map}],
      opts: opts
    })
  end

  @doc """
  Remove public organization membership for the authenticated user

  Removes the public membership for the authenticated user from the specified organization, unless public visibility is enforced by default.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#remove-public-organization-membership-for-the-authenticated-user)

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Remove a security manager team

  Removes the security manager role from a team for an organization. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization) team from an organization."

  To use this endpoint, you must be an administrator for the organization, and you must use an access token with the `admin:org` scope.

  GitHub Apps must have the `administration` organization read-write permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/security-managers#remove-a-security-manager-team)

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Review a request to access organization resources with a fine-grained personal access token

  Approves or denies a pending request to access organization resources via a fine-grained personal access token. Only GitHub Apps can call this API,
  using the `organization_personal_access_token_requests: write` permission.

  **Note**: Fine-grained PATs are in public beta. Related APIs, events, and functionality are subject to change.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/personal-access-tokens#review-a-request-to-access-organization-resources-with-a-fine-grained-personal-access-token)

  """
  @spec review_pat_grant_request(String.t(), integer, map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def review_pat_grant_request(org, pat_request_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, pat_request_id: pat_request_id, body: body],
      call: {GitHub.Orgs, :review_pat_grant_request},
      url: "/orgs/#{org}/personal-access-token-requests/#{pat_request_id}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {204, :null},
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

  Approves or denies multiple pending requests to access organization resources via a fine-grained personal access token. Only GitHub Apps can call this API,
  using the `organization_personal_access_token_requests: write` permission.

  **Note**: Fine-grained PATs are in public beta. Related APIs, events, and functionality are subject to change.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/personal-access-tokens#review-requests-to-access-organization-resources-with-fine-grained-personal-access-tokens)

  """
  @spec review_pat_grant_requests_in_bulk(String.t(), map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def review_pat_grant_requests_in_bulk(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Orgs, :review_pat_grant_requests_in_bulk},
      url: "/orgs/#{org}/personal-access-token-requests",
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

  Only authenticated organization owners can add a member to the organization or update the member's role.

  *   If the authenticated user is _adding_ a member to the organization, the invited user will receive an email inviting them to the organization. The user's [membership status](https://docs.github.com/rest/orgs/members#get-organization-membership-for-a-user) will be `pending` until they accept the invitation.
      
  *   Authenticated users can _update_ a user's membership by passing the `role` parameter. If the authenticated user changes a member's role to `admin`, the affected user will receive an email notifying them that they've been made an organization owner. If the authenticated user changes an owner's role to `member`, no email will be sent.

  **Rate limits**

  To prevent abuse, the authenticated user is limited to 50 organization invitations per 24 hour period. If the organization is more than one month old or on a paid plan, the limit is 500 invitations per 24 hour period.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#set-organization-membership-for-a-user)

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

  The user can publicize their own membership. (A user cannot publicize the membership for another user.)

  Note that you'll need to set `Content-Length` to zero when calling out to this endpoint. For more information, see "[HTTP verbs](https://docs.github.com/rest/overview/resources-in-the-rest-api#http-verbs)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#set-public-organization-membership-for-the-authenticated-user)

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
      response: [{204, :null}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Unblock a user from an organization

  Unblocks the given user on behalf of the specified organization.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/blocking#unblock-a-user-from-an-organization)

  """
  @spec unblock_user(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def unblock_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Orgs, :unblock_user},
      url: "/orgs/#{org}/blocks/#{username}",
      method: :delete,
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Update an organization

  **Parameter Deprecation Notice:** GitHub will replace and discontinue `members_allowed_repository_creation_type` in favor of more granular permissions. The new input parameters are `members_can_create_public_repositories`, `members_can_create_private_repositories` for all organizations and `members_can_create_internal_repositories` for organizations associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+. For more information, see the [blog post](https://developer.github.com/changes/2019-12-03-internal-visibility-changes).

  Enables an authenticated organization owner with the `admin:org` scope or the `repo` scope to update the organization's profile and member privileges.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/orgs#update-an-organization)

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
        {422, {:union, [{GitHub.ValidationError, :simple}, {GitHub.ValidationError, :t}]}}
      ],
      opts: opts
    })
  end

  @doc """
  Update an organization membership for the authenticated user

  Converts the authenticated user to an active member of the organization, if that user has a pending invitation from the organization.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/members#update-an-organization-membership-for-the-authenticated-user)

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

  Updates the access an organization member has to organization resources via a fine-grained personal access token. Limited to revoking the token's existing access. Limited to revoking a token's existing access. Only GitHub Apps can call this API,
  using the `organization_personal_access_tokens: write` permission.

  **Note**: Fine-grained PATs are in public beta. Related APIs, events, and functionality are subject to change.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/personal-access-tokens#update-the-access-a-fine-grained-personal-access-token-has-to-organization-resources)

  """
  @spec update_pat_access(String.t(), integer, map, keyword) :: :ok | {:error, GitHub.Error.t()}
  def update_pat_access(org, pat_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, pat_id: pat_id, body: body],
      call: {GitHub.Orgs, :update_pat_access},
      url: "/orgs/#{org}/personal-access-tokens/#{pat_id}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {204, :null},
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

  Updates the access organization members have to organization resources via fine-grained personal access tokens. Limited to revoking a token's existing access. Only GitHub Apps can call this API,
  using the `organization_personal_access_tokens: write` permission.

  **Note**: Fine-grained PATs are in public beta. Related APIs, events, and functionality are subject to change.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/personal-access-tokens#update-the-access-to-organization-resources-via-fine-grained-personal-access-tokens)

  """
  @spec update_pat_accesses(String.t(), map, keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def update_pat_accesses(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Orgs, :update_pat_accesses},
      url: "/orgs/#{org}/personal-access-tokens",
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

  Updates a webhook configured in an organization. When you update a webhook, the `secret` will be overwritten. If you previously had a `secret` set, you must provide the same `secret` or set a new `secret` or the secret will be removed. If you are only updating individual webhook `config` properties, use "[Update a webhook configuration for an organization](/rest/orgs/webhooks#update-a-webhook-configuration-for-an-organization)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/webhooks#update-an-organization-webhook)

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

  Updates the webhook configuration for an organization. To update more information about the webhook, including the `active` state and `events`, use "[Update an organization webhook ](/rest/orgs/webhooks#update-an-organization-webhook)."

  Access tokens must have the `admin:org_hook` scope, and GitHub Apps must have the `organization_hooks:write` permission.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/webhooks#update-a-webhook-configuration-for-an-organization)

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
