defmodule GitHub.App.InstallationRequest do
  @moduledoc """
  Provides struct and type for IntegrationInstallationRequest
  """

  @type t :: %__MODULE__{
          account: GitHub.Enterprise.t() | GitHub.User.simple(),
          created_at: String.t(),
          id: integer,
          node_id: String.t() | nil,
          requester: GitHub.User.simple()
        }

  defstruct [:account, :created_at, :id, :node_id, :requester]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      account: {:union, [{GitHub.User, :simple}, {GitHub.Enterprise, :t}]},
      created_at: :string,
      id: :integer,
      node_id: :string,
      requester: {GitHub.User, :simple}
    ]
  end
end
