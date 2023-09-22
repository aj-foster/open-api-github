defmodule GitHub.CodeScanning.AlertRuleSummary do
  @moduledoc """
  Provides struct and type for a CodeScanning.AlertRuleSummary
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          description: String.t() | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          severity: String.t() | nil,
          tags: [String.t()] | nil
        }

  defstruct [:__info__, :description, :id, :name, :severity, :tags]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: {:union, [{:string, :generic}, :null]},
      name: {:string, :generic},
      severity: {:enum, ["none", "note", "warning", "error", nil]},
      tags: {:union, [[string: :generic], :null]}
    ]
  end
end
