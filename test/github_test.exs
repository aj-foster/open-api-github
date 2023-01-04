defmodule GitHubTest do
  use ExUnit.Case

  alias GitHub.Config
  alias GitHub.Operation

  doctest GitHub.Config, except: [stack: 0]
  doctest GitHub.Operation
end
