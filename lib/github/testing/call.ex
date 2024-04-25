defmodule GitHub.Testing.Call do
  @moduledoc """
  Internal representation of an API call
  """

  @typedoc """
  Recorded API call
  """
  @type t :: %__MODULE__{
          args: [any],
          function: atom,
          module: module,
          opts: keyword
        }

  defstruct [:args, :function, :module, :opts]
end
