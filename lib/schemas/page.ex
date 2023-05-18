defmodule GitHub.Page do
  @moduledoc """
  Provides struct and type for Page
  """

  @type t :: %__MODULE__{
          __info__: map,
          build_type: String.t() | nil,
          cname: String.t() | nil,
          custom_404: boolean,
          html_url: String.t() | nil,
          https_certificate: GitHub.Pages.HttpsCertificate.t() | nil,
          https_enforced: boolean | nil,
          pending_domain_unverified_at: String.t() | nil,
          protected_domain_state: String.t() | nil,
          public: boolean,
          source: GitHub.Pages.SourceHash.t() | nil,
          status: String.t() | nil,
          url: String.t()
        }

  defstruct [
    :__info__,
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
      build_type: {:nullable, :string},
      cname: {:nullable, :string},
      custom_404: :boolean,
      html_url: :string,
      https_certificate: {GitHub.Pages.HttpsCertificate, :t},
      https_enforced: :boolean,
      pending_domain_unverified_at: {:nullable, :string},
      protected_domain_state: {:nullable, :string},
      public: :boolean,
      source: {GitHub.Pages.SourceHash, :t},
      status: {:nullable, :string},
      url: :string
    ]
  end
end
