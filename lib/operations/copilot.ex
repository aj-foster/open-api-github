defmodule GitHub.Copilot do
  @moduledoc """
  Provides API endpoints related to copilot
  """

  @default_client GitHub.Client

  @type add_copilot_seats_for_teams_201_json_resp :: %{__info__: map, seats_created: integer}

  @doc """
  Add teams to the Copilot subscription for an organization

  **Note**: This endpoint is in beta and is subject to change.

  Purchases a GitHub Copilot seat for all users within each specified team.
  The organization will be billed accordingly. For more information about Copilot pricing, see "[Pricing for GitHub Copilot](https://docs.github.com/billing/managing-billing-for-github-copilot/about-billing-for-github-copilot#about-billing-for-github-copilot)".

  Only organization owners can configure GitHub Copilot in their organization.

  In order for an admin to use this endpoint, the organization must have a Copilot Business or Enterprise subscription and a configured suggestion matching policy.
  For more information about setting up a Copilot subscription, see "[Setting up a Copilot subscription for your organization](https://docs.github.com/billing/managing-billing-for-github-copilot/managing-your-github-copilot-subscription-for-your-organization-or-enterprise)".
  For more information about setting a suggestion matching policy, see "[Configuring suggestion matching policies for GitHub Copilot in your organization](https://docs.github.com/copilot/managing-copilot/managing-policies-for-github-copilot-in-your-organization#configuring-suggestion-matching-policies-for-github-copilot-in-your-organization)".

  OAuth app tokens and personal access tokens (classic) need the `manage_billing:copilot` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-user-management#add-teams-to-the-copilot-subscription-for-an-organization)

  """
  @spec add_copilot_seats_for_teams(String.t(), map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def add_copilot_seats_for_teams(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Copilot, :add_copilot_seats_for_teams},
      url: "/orgs/#{org}/copilot/billing/selected_teams",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Copilot, :add_copilot_seats_for_teams_201_json_resp}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, :null},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @type add_copilot_seats_for_users_201_json_resp :: %{__info__: map, seats_created: integer}

  @doc """
  Add users to the Copilot subscription for an organization

  **Note**: This endpoint is in beta and is subject to change.

  Purchases a GitHub Copilot seat for each user specified.
  The organization will be billed accordingly. For more information about Copilot pricing, see "[Pricing for GitHub Copilot](https://docs.github.com/billing/managing-billing-for-github-copilot/about-billing-for-github-copilot#about-billing-for-github-copilot)".

  Only organization owners can configure GitHub Copilot in their organization.

  In order for an admin to use this endpoint, the organization must have a Copilot Business or Enterprise subscription and a configured suggestion matching policy.
  For more information about setting up a Copilot subscription, see "[Setting up a Copilot subscription for your organization](https://docs.github.com/billing/managing-billing-for-github-copilot/managing-your-github-copilot-subscription-for-your-organization-or-enterprise)".
  For more information about setting a suggestion matching policy, see "[Configuring suggestion matching policies for GitHub Copilot in your organization](https://docs.github.com/copilot/managing-copilot/managing-policies-for-github-copilot-in-your-organization#configuring-suggestion-matching-policies-for-github-copilot-in-your-organization)".

  OAuth app tokens and personal access tokens (classic) need the `manage_billing:copilot` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-user-management#add-users-to-the-copilot-subscription-for-an-organization)

  """
  @spec add_copilot_seats_for_users(String.t(), map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def add_copilot_seats_for_users(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Copilot, :add_copilot_seats_for_users},
      url: "/orgs/#{org}/copilot/billing/selected_users",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Copilot, :add_copilot_seats_for_users_201_json_resp}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, :null},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @type cancel_copilot_seat_assignment_for_teams_200_json_resp :: %{
          __info__: map,
          seats_cancelled: integer
        }

  @doc """
  Remove teams from the Copilot subscription for an organization

  **Note**: This endpoint is in beta and is subject to change.

  Cancels the Copilot seat assignment for all members of each team specified.
  This will cause the members of the specified team(s) to lose access to GitHub Copilot at the end of the current billing cycle, and the organization will not be billed further for those users.

  For more information about Copilot pricing, see "[Pricing for GitHub Copilot](https://docs.github.com/billing/managing-billing-for-github-copilot/about-billing-for-github-copilot#about-billing-for-github-copilot)".

  For more information about disabling access to Copilot Business or Enterprise, see "[Revoking access to GitHub Copilot for specific users in your organization](https://docs.github.com/copilot/managing-copilot/managing-access-for-copilot-in-your-organization#revoking-access-to-github-copilot-for-specific-users-in-your-organization)".

  Only organization owners can configure GitHub Copilot in their organization.

  OAuth app tokens and personal access tokens (classic) need the `manage_billing:copilot` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-user-management#remove-teams-from-the-copilot-subscription-for-an-organization)

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
        {200, {GitHub.Copilot, :cancel_copilot_seat_assignment_for_teams_200_json_resp}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, :null},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @type cancel_copilot_seat_assignment_for_users_200_json_resp :: %{
          __info__: map,
          seats_cancelled: integer
        }

  @doc """
  Remove users from the Copilot subscription for an organization

  **Note**: This endpoint is in beta and is subject to change.

  Cancels the Copilot seat assignment for each user specified.
  This will cause the specified users to lose access to GitHub Copilot at the end of the current billing cycle, and the organization will not be billed further for those users.

  For more information about Copilot pricing, see "[Pricing for GitHub Copilot](https://docs.github.com/billing/managing-billing-for-github-copilot/about-billing-for-github-copilot#about-billing-for-github-copilot)".

  For more information about disabling access to Copilot Business or Enterprise, see "[Revoking access to GitHub Copilot for specific users in your organization](https://docs.github.com/copilot/managing-copilot/managing-access-for-copilot-in-your-organization#revoking-access-to-github-copilot-for-specific-users-in-your-organization)".

  Only organization owners can configure GitHub Copilot in their organization.

  OAuth app tokens and personal access tokens (classic) need the `manage_billing:copilot` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-user-management#remove-users-from-the-copilot-subscription-for-an-organization)

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
        {200, {GitHub.Copilot, :cancel_copilot_seat_assignment_for_users_200_json_resp}},
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
  Get Copilot seat information and settings for an organization

  **Note**: This endpoint is in beta and is subject to change.

  Gets information about an organization's Copilot subscription, including seat breakdown
  and code matching policies. To configure these settings, go to your organization's settings on GitHub.com.
  For more information, see "[Managing policies for Copilot in your organization](https://docs.github.com/copilot/managing-copilot/managing-policies-for-copilot-business-in-your-organization)".

  Only organization owners can configure and view details about the organization's Copilot Business subscription.

  OAuth app tokens and personal access tokens (classic) need the `manage_billing:copilot` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-user-management#get-copilot-seat-information-and-settings-for-an-organization)

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
  Get Copilot seat assignment details for a user

  **Note**: This endpoint is in beta and is subject to change.

  Gets the GitHub Copilot seat assignment details for a member of an organization who currently has access to GitHub Copilot.

  Organization owners can view GitHub Copilot seat assignment details for members in their organization.

  OAuth app tokens and personal access tokens (classic) need the `manage_billing:copilot` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-user-management#get-copilot-seat-assignment-details-for-a-user)

  """
  @spec get_copilot_seat_details_for_user(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Copilot.SeatDetails.t()} | {:error, GitHub.Error.t()}
  def get_copilot_seat_details_for_user(org, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Copilot, :get_copilot_seat_details_for_user},
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

  @type list_copilot_seats_200_json_resp :: %{
          __info__: map,
          seats: [GitHub.Copilot.SeatDetails.t()] | nil,
          total_seats: integer | nil
        }

  @doc """
  List all Copilot seat assignments for an organization

  **Note**: This endpoint is in beta and is subject to change.

  Lists all Copilot seat assignments for an organization that are currently being billed (either active or pending cancellation at the start of the next billing cycle).

  Only organization owners can configure and view details about the organization's Copilot Business or Enterprise subscription.

  OAuth app tokens and personal access tokens (classic) need the `manage_billing:copilot` scope to use this endpoint.

  ## Options

    * `page`: The page number of the results to fetch. For more information, see "[Using pagination in the REST API](https://docs.github.com/rest/using-the-rest-api/using-pagination-in-the-rest-api)."
    * `per_page`: The number of results per page (max 100). For more information, see "[Using pagination in the REST API](https://docs.github.com/rest/using-the-rest-api/using-pagination-in-the-rest-api)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/copilot/copilot-user-management#list-all-copilot-seat-assignments-for-an-organization)

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
        {200, {GitHub.Copilot, :list_copilot_seats_200_json_resp}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:add_copilot_seats_for_teams_201_json_resp) do
    [seats_created: :integer]
  end

  def __fields__(:add_copilot_seats_for_users_201_json_resp) do
    [seats_created: :integer]
  end

  def __fields__(:cancel_copilot_seat_assignment_for_teams_200_json_resp) do
    [seats_cancelled: :integer]
  end

  def __fields__(:cancel_copilot_seat_assignment_for_users_200_json_resp) do
    [seats_cancelled: :integer]
  end

  def __fields__(:list_copilot_seats_200_json_resp) do
    [seats: [{GitHub.Copilot.SeatDetails, :t}], total_seats: :integer]
  end
end
