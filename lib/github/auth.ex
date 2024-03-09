defprotocol GitHub.Auth do
  @moduledoc """
  Protocol for extracting API authentication tokens from application structs

  Credentials can be passed to operations using the `auth` option as strings (for tokens) or
  2-tuples (for client ID / secret or username / password). Sometimes, it's more convenient to pass
  a struct — like as a user struct — and extract the auth token from that.

  By implementing this protocol, the client can extract an auth token from the given struct without
  additional work by the caller.

  ## Example

      defimpl GitHub.Auth, for: MyApp.User do
        def to_auth(%MyApp.User{github_token: token}), do: token
      end

  ## Provided Implementations

  This library provides several implementations for the protocol based on library structs.

  ### GitHub.App

  For app structs with `id` and `pem` fields containing the GitHub App ID and private key
  (respectively), the default implementation will generate a JWT compatible with certain API
  endpoints. Generally, the PEM field can only be filled in manually. To assist with this, the
  helper function `GitHub.app/1` will construct a valid app struct using configured values.

  Creating a JWT requires the optional dependency `JOSE`.

  JWTs are made to last for several minutes, so it is prudent to cache values between requests.
  See `GitHub.Auth.Cache` for a built-in caching mechanism.
  """

  @typedoc "Auth token accepted by the client"
  @type auth ::
          nil
          | (token :: String.t())
          | {username_or_client_id :: String.t(), password_or_client_secret :: String.t()}

  @doc """
  Extract an auth token from the given struct

  The returned data should be in the form of a string (for a Bearer token) or a 2-tuple (for a Basic
  Auth user/password pair).
  """
  @spec to_auth(t) :: auth
  def to_auth(value)
end

if Code.ensure_loaded?(JOSE) do
  defimpl GitHub.Auth, for: GitHub.App do
    @token_clock_drift_allowance_sec 60
    @token_duration_sec 10 * 60

    def to_auth(%{id: app_id, pem: private_key}) do
      case GitHub.Auth.Cache.get({:app, app_id}) do
        {:ok, jwt} ->
          jwt

        _else ->
          time = DateTime.utc_now() |> DateTime.to_unix(:second)
          expiration = time - @token_clock_drift_allowance_sec + @token_duration_sec

          claims = %{
            "iat" => time - @token_clock_drift_allowance_sec,
            "exp" => expiration,
            "iss" => app_id
          }

          jwk = JOSE.JWK.from_pem(private_key)
          jws = JOSE.JWS.from_map(%{"alg" => "RS256", "typ" => "JWT"})

          {_, jwt} =
            JOSE.JWT.sign(jwk, jws, claims)
            |> JOSE.JWS.compact()

          GitHub.Auth.Cache.put({:app, app_id}, expiration, jwt)
          jwt
      end
    end
  end
else
  defimpl GitHub.Auth, for: GitHub.App do
    def to_auth(app) do
      raise GitHub.Error.new(
              source: app,
              message: """
              JOSE Not Installed

              Optional dependency JOSE was not installed at the
              time `GitHub.Auth` was compiled. Please ensure it
              is installed and run:

              `mix deps.compile --force oapi_github`
              """
            )
    end
  end
end
