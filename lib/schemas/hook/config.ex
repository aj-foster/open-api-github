defmodule GitHub.Hook.Config do
  @moduledoc """
  Provides struct and type for a Hook.Config
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          content_type: String.t() | nil,
          digest: String.t() | nil,
          email: String.t() | nil,
          insecure_ssl: number | String.t() | nil,
          password: String.t() | nil,
          room: String.t() | nil,
          secret: String.t() | nil,
          subdomain: String.t() | nil,
          token: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [
    :__info__,
    :content_type,
    :digest,
    :email,
    :insecure_ssl,
    :password,
    :room,
    :secret,
    :subdomain,
    :token,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      content_type: {:string, :generic},
      digest: {:string, :generic},
      email: {:string, :generic},
      insecure_ssl: {:union, [:number, string: :generic]},
      password: {:string, :generic},
      room: {:string, :generic},
      secret: {:string, :generic},
      subdomain: {:string, :generic},
      token: {:string, :generic},
      url: {:string, :uri}
    ]
  end
end
