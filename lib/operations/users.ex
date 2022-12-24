defmodule GitHub.Users do
  @moduledoc """
  Provides API endpoints related to users
  """

  @default_client GitHub.Client

  @doc """
  Add an email address for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#add-an-email-address-for-the-authenticated-user)

  """
  @spec add_email_for_authenticated_user(map | String.t() | [String.t()], keyword) ::
          {:ok, [GitHub.Email.t()]} | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def add_email_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/emails",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, {:array, :string}, :string]}}],
      response: [
        {201, {:array, {GitHub.Email, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Block a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#block-a-user)

  """
  @spec block(String.t(), keyword) ::
          :ok | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def block(username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/blocks/#{username}",
      method: :put,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Check if a user is blocked by the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#check-if-a-user-is-blocked-by-the-authenticated-user)

  """
  @spec check_blocked(String.t(), keyword) :: :ok | {:error, GitHub.BasicError.t()}
  def check_blocked(username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/blocks/#{username}",
      method: :get,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Check if a user follows another user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#check-if-a-user-follows-another-user)

  """
  @spec check_following_for_user(String.t(), String.t(), keyword) :: :ok | :error
  def check_following_for_user(username, target_user, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/users/#{username}/following/#{target_user}",
      method: :get,
      response: [{204, nil}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Check if a person is followed by the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#check-if-a-person-is-followed-by-the-authenticated-user)

  """
  @spec check_person_is_followed_by_authenticated(String.t(), keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def check_person_is_followed_by_authenticated(username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/following/#{username}",
      method: :get,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a GPG key for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#create-a-gpg-key-for-the-authenticated-user)

  """
  @spec create_gpg_key_for_authenticated_user(map, keyword) ::
          {:ok, GitHub.GpgKey.t()} | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def create_gpg_key_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/gpg_keys",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.GpgKey, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a public SSH key for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#create-a-public-ssh-key-for-the-authenticated-user)

  """
  @spec create_public_ssh_key_for_authenticated_user(map, keyword) ::
          {:ok, GitHub.Key.t()} | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def create_public_ssh_key_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/keys",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Key, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a SSH signing key for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#create-an-ssh-signing-key-for-the-authenticated-user)

  """
  @spec create_ssh_signing_key_for_authenticated_user(map, keyword) ::
          {:ok, GitHub.SSHSigningKey.t()}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def create_ssh_signing_key_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/ssh_signing_keys",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.SSHSigningKey, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete an email address for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#delete-an-email-address-for-the-authenticated-user)

  """
  @spec delete_email_for_authenticated_user(map | String.t() | [String.t()], keyword) ::
          :ok | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def delete_email_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/emails",
      body: body,
      method: :delete,
      request: [{"application/json", {:union, [:map, {:array, :string}, :string]}}],
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a GPG key for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#delete-a-gpg-key-for-the-authenticated-user)

  """
  @spec delete_gpg_key_for_authenticated_user(integer, keyword) ::
          :ok | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def delete_gpg_key_for_authenticated_user(gpg_key_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/gpg_keys/#{gpg_key_id}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a public SSH key for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#delete-a-public-ssh-key-for-the-authenticated-user)

  """
  @spec delete_public_ssh_key_for_authenticated_user(integer, keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def delete_public_ssh_key_for_authenticated_user(key_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/keys/#{key_id}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete an SSH signing key for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#delete-a-ssh-signing-key-for-the-authenticated-user)

  """
  @spec delete_ssh_signing_key_for_authenticated_user(integer, keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def delete_ssh_signing_key_for_authenticated_user(ssh_signing_key_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/ssh_signing_keys/#{ssh_signing_key_id}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Follow a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#follow-a-user)

  """
  @spec follow(String.t(), keyword) :: :ok | {:error, GitHub.BasicError.t()}
  def follow(username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/following/#{username}",
      method: :put,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#get-the-authenticated-user)

  """
  @spec get_authenticated(keyword) ::
          {:ok, GitHub.User.private() | GitHub.User.public()} | {:error, GitHub.BasicError.t()}
  def get_authenticated(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user",
      method: :get,
      response: [
        {200, {:union, [{GitHub.User, :private}, {GitHub.User, :public}]}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#get-a-user)

  """
  @spec get_by_username(String.t(), keyword) ::
          {:ok, GitHub.User.private() | GitHub.User.public()} | {:error, GitHub.BasicError.t()}
  def get_by_username(username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/users/#{username}",
      method: :get,
      response: [
        {200, {:union, [{GitHub.User, :private}, {GitHub.User, :public}]}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get contextual information for a user

  ## Options

    * `subject_type` (String.t()): Identifies which additional information you'd like to receive about the person's hovercard. Can be `organization`, `repository`, `issue`, `pull_request`. **Required** when using `subject_id`.
    * `subject_id` (String.t()): Uses the ID for the `subject_type` you specified. **Required** when using `subject_type`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#get-contextual-information-for-a-user)

  """
  @spec get_context_for_user(String.t(), keyword) ::
          {:ok, GitHub.Hovercard.t()}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def get_context_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:subject_id, :subject_type])

    client.request(%{
      url: "/users/#{username}/hovercard",
      method: :get,
      query: query,
      response: [
        {200, {GitHub.Hovercard, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a GPG key for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#get-a-gpg-key-for-the-authenticated-user)

  """
  @spec get_gpg_key_for_authenticated_user(integer, keyword) ::
          {:ok, GitHub.GpgKey.t()} | {:error, GitHub.BasicError.t()}
  def get_gpg_key_for_authenticated_user(gpg_key_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/gpg_keys/#{gpg_key_id}",
      method: :get,
      response: [
        {200, {GitHub.GpgKey, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a public SSH key for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#get-a-public-ssh-key-for-the-authenticated-user)

  """
  @spec get_public_ssh_key_for_authenticated_user(integer, keyword) ::
          {:ok, GitHub.Key.t()} | {:error, GitHub.BasicError.t()}
  def get_public_ssh_key_for_authenticated_user(key_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/keys/#{key_id}",
      method: :get,
      response: [
        {200, {GitHub.Key, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get an SSH signing key for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#get-a-ssh-signing-key-for-the-authenticated-user)

  """
  @spec get_ssh_signing_key_for_authenticated_user(integer, keyword) ::
          {:ok, GitHub.SSHSigningKey.t()} | {:error, GitHub.BasicError.t()}
  def get_ssh_signing_key_for_authenticated_user(ssh_signing_key_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/ssh_signing_keys/#{ssh_signing_key_id}",
      method: :get,
      response: [
        {200, {GitHub.SSHSigningKey, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List users

  ## Options

    * `since` (integer): A user ID. Only return users with an ID greater than this ID.
    * `per_page` (integer): The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-users)

  """
  @spec list(keyword) :: {:ok, [GitHub.User.simple()]} | :error
  def list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:per_page, :since])

    client.request(%{
      url: "/users",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}, {304, nil}],
      opts: opts
    })
  end

  @doc """
  List users blocked by the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-users-blocked-by-the-authenticated-user)

  """
  @spec list_blocked_by_authenticated_user(keyword) ::
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.BasicError.t()}
  def list_blocked_by_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/user/blocks",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.User, :simple}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List email addresses for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-email-addresses-for-the-authenticated-user)

  """
  @spec list_emails_for_authenticated_user(keyword) ::
          {:ok, [GitHub.Email.t()]} | {:error, GitHub.BasicError.t()}
  def list_emails_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/user/emails",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Email, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List the people the authenticated user follows

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-the-people-the-authenticated-user-follows)

  """
  @spec list_followed_by_authenticated_user(keyword) ::
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.BasicError.t()}
  def list_followed_by_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/user/following",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.User, :simple}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List followers of the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-followers-of-the-authenticated-user)

  """
  @spec list_followers_for_authenticated_user(keyword) ::
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.BasicError.t()}
  def list_followers_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/user/followers",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.User, :simple}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List followers of a user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-followers-of-a-user)

  """
  @spec list_followers_for_user(String.t(), keyword) :: {:ok, [GitHub.User.simple()]} | :error
  def list_followers_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/users/#{username}/followers",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}],
      opts: opts
    })
  end

  @doc """
  List the people a user follows

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-the-people-a-user-follows)

  """
  @spec list_following_for_user(String.t(), keyword) :: {:ok, [GitHub.User.simple()]} | :error
  def list_following_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/users/#{username}/following",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}],
      opts: opts
    })
  end

  @doc """
  List GPG keys for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-gpg-keys-for-the-authenticated-user)

  """
  @spec list_gpg_keys_for_authenticated_user(keyword) ::
          {:ok, [GitHub.GpgKey.t()]} | {:error, GitHub.BasicError.t()}
  def list_gpg_keys_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/user/gpg_keys",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.GpgKey, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List GPG keys for a user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-gpg-keys-for-a-user)

  """
  @spec list_gpg_keys_for_user(String.t(), keyword) :: {:ok, [GitHub.GpgKey.t()]} | :error
  def list_gpg_keys_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/users/#{username}/gpg_keys",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.GpgKey, :t}}}],
      opts: opts
    })
  end

  @doc """
  List public email addresses for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-public-email-addresses-for-the-authenticated-user)

  """
  @spec list_public_emails_for_authenticated_user(keyword) ::
          {:ok, [GitHub.Email.t()]} | {:error, GitHub.BasicError.t()}
  def list_public_emails_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/user/public_emails",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Email, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List public keys for a user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-public-keys-for-a-user)

  """
  @spec list_public_keys_for_user(String.t(), keyword) :: {:ok, [GitHub.Key.simple()]} | :error
  def list_public_keys_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/users/#{username}/keys",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Key, :simple}}}],
      opts: opts
    })
  end

  @doc """
  List public SSH keys for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-public-ssh-keys-for-the-authenticated-user)

  """
  @spec list_public_ssh_keys_for_authenticated_user(keyword) ::
          {:ok, [GitHub.Key.t()]} | {:error, GitHub.BasicError.t()}
  def list_public_ssh_keys_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/user/keys",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Key, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List SSH signing keys for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-public-ssh-signing-keys-for-the-authenticated-user)

  """
  @spec list_ssh_signing_keys_for_authenticated_user(keyword) ::
          {:ok, [GitHub.SSHSigningKey.t()]} | {:error, GitHub.BasicError.t()}
  def list_ssh_signing_keys_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/user/ssh_signing_keys",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.SSHSigningKey, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List SSH signing keys for a user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#list-ssh-signing-keys-for-a-user)

  """
  @spec list_ssh_signing_keys_for_user(String.t(), keyword) ::
          {:ok, [GitHub.SSHSigningKey.t()]} | :error
  def list_ssh_signing_keys_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/users/#{username}/ssh_signing_keys",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.SSHSigningKey, :t}}}],
      opts: opts
    })
  end

  @doc """
  Set primary email visibility for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#set-primary-email-visibility-for-the-authenticated-user)

  """
  @spec set_primary_email_visibility_for_authenticated_user(map, keyword) ::
          {:ok, [GitHub.Email.t()]} | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def set_primary_email_visibility_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/email/visibility",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {:array, {GitHub.Email, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Unblock a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#unblock-a-user)

  """
  @spec unblock(String.t(), keyword) :: :ok | {:error, GitHub.BasicError.t()}
  def unblock(username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/blocks/#{username}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Unfollow a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users#unfollow-a-user)

  """
  @spec unfollow(String.t(), keyword) :: :ok | {:error, GitHub.BasicError.t()}
  def unfollow(username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/following/#{username}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/users/#update-the-authenticated-user)

  """
  @spec update_authenticated(map, keyword) ::
          {:ok, GitHub.User.private()}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def update_authenticated(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.User, :private}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end
end
