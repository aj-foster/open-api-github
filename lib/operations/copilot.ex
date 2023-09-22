defmodule GitHub.Copilot do
  @moduledoc """
  Provides API endpoints related to copilot
  """

  @default_client GitHub.Client

  @doc """
  Add teams to the Copilot for Business subscription for an organization

  **Note**: This endpoint is in beta and is subject to change.

   Purchases a GitHub Copilot for Business seat for all users within each specified team.
   The organization will be billed accordingly. For more information about Copilot for Business pricing, see "[About billing for GitHub Copilot for Business](https://docs.github.com/billing/managing-billing-for-github-copilot/about-billing-for-github-copilot#pricing-for-github-copilot-for-business)".

   Only organization owners and members with admin permissions can configure GitHub Copilot in their organization. You must
   authenticate using an access token with the `manage_billing:copilot` scope to use this endpoint.

   In order for an admin to use this endpoint, the organization must have a Copilot for Business subscription and a configured suggestion matching policy.
   For more information about setting up a Copilot for Business subscription, see "[Setting up a Copilot for Business subscription for your organization](https://docs.github.com/billing/managing-billing-for-github-copilot/managing-your-github-copilot-subscription-for-your-organization-or-enterprise#setting-up-a-copilot-for-business-subscription-for-your-organization)".
   For more information about setting a suggestion matching policy, see "[Configuring suggestion matching policies for GitHub Copilot in your organization](https://docs.github.com/copilot/configuring-github-copilot/configuring-github-copilot-settings-in-your-organization#configuring-suggestion-matching-policies-for-github-copilot-in-your-organization)".

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-for-business#add-teams-to-the-copilot-for-business-subscription-for-an-organization)

  """
  @spec add_copilot_for_business_seats_for_teams(String.t(), map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def add_copilot_for_business_seats_for_teams(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Copilot, :add_copilot_for_business_seats_for_teams},
      url: "/orgs/#{org}/copilot/billing/selected_teams",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, :map},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, :null},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add users to the Copilot for Business subscription for an organization

  **Note**: This endpoint is in beta and is subject to change.

  Purchases a GitHub Copilot for Business seat for each user specified.
  The organization will be billed accordingly. For more information about Copilot for Business pricing, see "[About billing for GitHub Copilot for Business](https://docs.github.com/billing/managing-billing-for-github-copilot/about-billing-for-github-copilot#pricing-for-github-copilot-for-business)".

  Only organization owners and members with admin permissions can configure GitHub Copilot in their organization. You must
  authenticate using an access token with the `manage_billing:copilot` scope to use this endpoint.

  In order for an admin to use this endpoint, the organization must have a Copilot for Business subscription and a configured suggestion matching policy.
  For more information about setting up a Copilot for Business subscription, see "[Setting up a Copilot for Business subscription for your organization](https://docs.github.com/billing/managing-billing-for-github-copilot/managing-your-github-copilot-subscription-for-your-organization-or-enterprise#setting-up-a-copilot-for-business-subscription-for-your-organization)".
  For more information about setting a suggestion matching policy, see "[Configuring suggestion matching policies for GitHub Copilot in your organization](https://docs.github.com/copilot/configuring-github-copilot/configuring-github-copilot-settings-in-your-organization#configuring-suggestion-matching-policies-for-github-copilot-in-your-organization)".

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-for-business#add-users-to-the-copilot-for-business-subscription-for-an-organization)

  """
  @spec add_copilot_for_business_seats_for_users(String.t(), map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def add_copilot_for_business_seats_for_users(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Copilot, :add_copilot_for_business_seats_for_users},
      url: "/orgs/#{org}/copilot/billing/selected_users",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, :map},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, :null},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove teams from the Copilot for Business subscription for an organization

  **Note**: This endpoint is in beta and is subject to change.

  Cancels the Copilot for Business seat assignment for all members of each team specified.
  This will cause the members of the specified team(s) to lose access to GitHub Copilot at the end of the current billing cycle, and the organization will not be billed further for those users.

  For more information about Copilot for Business pricing, see "[About billing for GitHub Copilot for Business](https://docs.github.com/billing/managing-billing-for-github-copilot/about-billing-for-github-copilot#pricing-for-github-copilot-for-business)".

  For more information about disabling access to Copilot for Business, see "[Disabling access to GitHub Copilot for specific users in your organization](https://docs.github.com/copilot/configuring-github-copilot/configuring-github-copilot-settings-in-your-organization#disabling-access-to-github-copilot-for-specific-users-in-your-organization)".

  Only organization owners and members with admin permissions can configure GitHub Copilot in their organization. You must
  authenticate using an access token with the `manage_billing:copilot` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-for-business#remove-teams-from-the-copilot-for-business-subscription-for-an-organization)

  """
  @spec cancel_copilot_seat_assignment_for_teams(String.t(), map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def cancel_copilot_seat_assignment_for_teams(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Copilot, :cancel_copilot_seat_assignment_for_teams},
      url: "/orgs/#{org}/copilot/billing/selected_teams",
      body: body,
      method: :delete,
      request: [{"application/json", :map}],
      response: [
        {200, :map},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, :null},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove users from the Copilot for Business subscription for an organization

  **Note**: This endpoint is in beta and is subject to change.

  Cancels the Copilot for Business seat assignment for each user specified.
  This will cause the specified users to lose access to GitHub Copilot at the end of the current billing cycle, and the organization will not be billed further for those users.

  For more information about Copilot for Business pricing, see "[About billing for GitHub Copilot for Business](https://docs.github.com/billing/managing-billing-for-github-copilot/about-billing-for-github-copilot#pricing-for-github-copilot-for-business)"

  For more information about disabling access to Copilot for Business, see "[Disabling access to GitHub Copilot for specific users in your organization](https://docs.github.com/copilot/configuring-github-copilot/configuring-github-copilot-settings-in-your-organization#disabling-access-to-github-copilot-for-specific-users-in-your-organization)".

  Only organization owners and members with admin permissions can configure GitHub Copilot in their organization. You must
  authenticate using an access token with the `manage_billing:copilot` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-for-business#remove-users-from-the-copilot-for-business-subscription-for-an-organization)

  """
  @spec cancel_copilot_seat_assignment_for_users(String.t(), map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def cancel_copilot_seat_assignment_for_users(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Copilot, :cancel_copilot_seat_assignment_for_users},
      url: "/orgs/#{org}/copilot/billing/selected_users",
      body: body,
      method: :delete,
      request: [{"application/json", :map}],
      response: [
        {200, :map},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, :null},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get Copilot for Business seat information and settings for an organization

  **Note**: This endpoint is in beta and is subject to change.

  Gets information about an organization's Copilot for Business subscription, including seat breakdown
  and code matching policies. To configure these settings, go to your organization's settings on GitHub.com.
  For more information, see "[Configuring GitHub Copilot settings in your organization](https://docs.github.com/copilot/configuring-github-copilot/configuring-github-copilot-settings-in-your-organization)".

  Only organization owners and members with admin permissions can configure and view details about the organization's Copilot for Business subscription. You must
  authenticate using an access token with the `manage_billing:copilot` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-for-business#get-copilot-for-business-seat-information-and-settings-for-an-organization)

  """
  @spec get_copilot_organization_details(String.t(), keyword) ::
          {:ok, GitHub.Copilot.OrganizationDetails.t()} | {:error, GitHub.Error.t()}
  def get_copilot_organization_details(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Copilot, :get_copilot_organization_details},
      url: "/orgs/#{org}/copilot/billing",
      method: :get,
      response: [
        {200, {GitHub.Copilot.OrganizationDetails, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get Copilot for Business seat assignment details for a user

  **Note**: This endpoint is in beta and is subject to change.

  Gets the GitHub Copilot for Business seat assignment details for a member of an organization who currently has access to GitHub Copilot.

  Organization owners and members with admin permissions can view GitHub Copilot seat assignment details for members in their organization. You must authenticate using an access token with the `manage_billing:copilot` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-for-business#get-copilot-for-business-seat-assignment-details-for-a-user)

  """
  @spec get_copilot_seat_assignment_details_for_user(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Copilot.SeatDetails.t()} | {:error, GitHub.Error.t()}
  def get_copilot_seat_assignment_details_for_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Copilot, :get_copilot_seat_assignment_details_for_user},
      url: "/orgs/#{org}/members/#{username}/copilot",
      method: :get,
      response: [
        {200, {GitHub.Copilot.SeatDetails, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, :null},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List all Copilot for Business seat assignments for an organization

  **Note**: This endpoint is in beta and is subject to change.

  Lists all Copilot for Business seat assignments for an organization that are currently being billed (either active or pending cancellation at the start of the next billing cycle).

  Only organization owners and members with admin permissions can configure and view details about the organization's Copilot for Business subscription. You must
  authenticate using an access token with the `manage_billing:copilot` scope to use this endpoint.

  ## Options

    * `page`: Page number of the results to fetch.
    * `per_page`: The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-for-business#list-all-copilot-for-business-seat-assignments-for-an-organization)

  """
  @spec list_copilot_seats(String.t(), keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_copilot_seats(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Copilot, :list_copilot_seats},
      url: "/orgs/#{org}/copilot/billing/seats",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end
end
