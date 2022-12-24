defprotocol GitHub.Auth do
  @type auth ::
          nil
          | (token :: String.t())
          | {username_or_client_id :: String.t(), password_or_client_secret :: String.t()}

  @spec to_auth(term) :: auth
  def to_auth(value)
end
