defmodule GitHub.Timeline.CommittedEvent do
  @moduledoc """
  Provides struct and type for a Timeline.CommittedEvent
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          author: map,
          committer: map,
          event: String.t() | nil,
          html_url: String.t(),
          message: String.t(),
          node_id: String.t(),
          parents: [map],
          sha: String.t(),
          tree: map,
          url: String.t(),
          verification: map
        }

  defstruct [
    :__info__,
    :author,
    :committer,
    :event,
    :html_url,
    :message,
    :node_id,
    :parents,
    :sha,
    :tree,
    :url,
    :verification
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      author: :map,
      committer: :map,
      event: {:string, :generic},
      html_url: {:string, :uri},
      message: {:string, :generic},
      node_id: {:string, :generic},
      parents: [:map],
      sha: {:string, :generic},
      tree: :map,
      url: {:string, :uri},
      verification: :map
    ]
  end
end
