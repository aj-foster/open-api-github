defmodule GitHub do
  alias GitHub.Error
  alias GitHub.Operation

  @doc """
  Run a client operation and return the raw Operation or Error

  Normal client operation calls return only the response body. This function can be useful when
  the caller needs additional information, such as data from the response headers.

  The `args` passed to this function should not include the `opts` argument usually available on
  client operations. Instead, any such options should be passed as the final argument to `raw/4`.

  ## Example

      iex> GitHub.raw(GitHub.Users, :get_authenticated, [])
      {:ok, %GitHub.Operation{}}

  """
  @spec raw(module, atom, [any], keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def raw(module, function, args, opts \\ []) do
    opts = Keyword.put(opts, :wrap, false)

    case apply(module, function, args ++ [opts]) do
      %Operation{} = operation -> {:ok, operation}
      %Error{} = error -> {:ok, error}
    end
  end
end
