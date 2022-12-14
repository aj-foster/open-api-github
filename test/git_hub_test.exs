defmodule GitHubTest do
  use ExUnit.Case
  doctest GitHub

  test "greets the world" do
    assert GitHub.hello() == :world
  end
end
