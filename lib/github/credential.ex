defmodule GitHub.Credential do
  @type type :: :basic | :jwt | :token

  defstruct [
    :basic_auth_password,
    :basic_auth_username,
    :bearer_token,
    :type
  ]
end
