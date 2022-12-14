defmodule GitHub.Actions.Runner.Application do
  @moduledoc """
  Provides struct and type for RunnerApplication
  """

  @type t :: %__MODULE__{
          architecture: String.t(),
          download_url: String.t(),
          filename: String.t(),
          os: String.t(),
          sha256_checksum: String.t() | nil,
          temp_download_token: String.t() | nil
        }

  defstruct [:architecture, :download_url, :filename, :os, :sha256_checksum, :temp_download_token]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      architecture: :string,
      download_url: :string,
      filename: :string,
      os: :string,
      sha256_checksum: :string,
      temp_download_token: :string
    ]
  end
end
