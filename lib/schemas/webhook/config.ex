defmodule GitHub.Webhook.Config do
  @moduledoc """
  Provides struct and type for WebhookConfig
  """

  @type t :: %__MODULE__{
          content_type: String.t() | nil,
          insecure_ssl: (number | String.t()) | nil,
          secret: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [:content_type, :insecure_ssl, :secret, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      content_type: :string,
      insecure_ssl: {:union, [:string, :number]},
      secret: :string,
      url: :string
    ]
  end
end
