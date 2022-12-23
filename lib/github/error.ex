defmodule GitHub.Error do
  @type t :: %__MODULE__{}
  @derive {Inspect, except: [:operation, :stacktrace]}
  defexception [:code, :message, :operation, :source, :stacktrace, :step]

  @spec new(keyword) :: t
  def new(opts) do
    {:current_stacktrace, stack} = Process.info(self(), :current_stacktrace)
    # Drop `Process.info/2` and `new/1`.
    stacktrace = Enum.drop(stack, 2)

    struct!(%__MODULE__{stacktrace: stacktrace}, opts)
  end
end
