defmodule GitHub.Branch.WithProtection do
  @moduledoc """
  Provides struct and type for BranchWithProtection
  """

  @type t :: %__MODULE__{
          _links: map,
          commit: GitHub.Commit.t(),
          name: String.t(),
          pattern: String.t() | nil,
          protected: boolean,
          protection: GitHub.Branch.Protection.t(),
          protection_url: String.t(),
          required_approving_review_count: integer | nil
        }

  defstruct [
    :_links,
    :commit,
    :name,
    :pattern,
    :protected,
    :protection,
    :protection_url,
    :required_approving_review_count
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      _links: :map,
      commit: {GitHub.Commit, :t},
      name: :string,
      pattern: :string,
      protected: :boolean,
      protection: {GitHub.Branch.Protection, :t},
      protection_url: :string,
      required_approving_review_count: :integer
    ]
  end
end
