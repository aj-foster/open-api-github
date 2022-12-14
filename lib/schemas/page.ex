defmodule GitHub.Page do
  @moduledoc """
  Provides struct and type for Page
  """

  @type t :: %__MODULE__{
          build_type: String.t() | nil,
          cname: String.t() | nil,
          custom_404: boolean,
          html_url: String.t() | nil,
          https_certificate: :"Elixir.GitHub.Page.sHttpsCertificate".t() | nil,
          https_enforced: boolean | nil,
          pending_domain_unverified_at: String.t() | nil,
          protected_domain_state: String.t() | nil,
          public: boolean,
          source: :"Elixir.GitHub.Page.sSourceHash".t() | nil,
          status: String.t() | nil,
          url: String.t()
        }

  defstruct [
    :build_type,
    :cname,
    :custom_404,
    :html_url,
    :https_certificate,
    :https_enforced,
    :pending_domain_unverified_at,
    :protected_domain_state,
    :public,
    :source,
    :status,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      build_type: :string,
      cname: :string,
      custom_404: :boolean,
      html_url: :string,
      https_certificate: {:"Elixir.GitHub.Page.sHttpsCertificate", :t},
      https_enforced: :boolean,
      pending_domain_unverified_at: :string,
      protected_domain_state: :string,
      public: :boolean,
      source: {:"Elixir.GitHub.Page.sSourceHash", :t},
      status: :string,
      url: :string
    ]
  end
end
