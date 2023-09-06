defmodule GitHub.Copilot do
  @moduledoc """
  Provides API endpoints related to copilot
  """

  @default_client GitHub.Client

  @doc """
  Add teams to the Copilot for Business subscription for an organization

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
        {422, nil},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add users to the Copilot for Business subscription for an organization

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
        {422, nil},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove teams from the Copilot for Business subscription for an organization

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
        {422, nil},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove users from the Copilot for Business subscription for an organization

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
        {422, nil},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get Copilot for Business seat information and settings for an organization

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
        {422, nil},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List all Copilot for Business seat assignments for an organization

  ## Options

    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).

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
