defmodule GitHub.ClientError do
  @type t :: %__MODULE__{}
  defexception [:message, :phase, :source, :stacktrace]
end
