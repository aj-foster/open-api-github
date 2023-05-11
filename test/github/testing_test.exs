defmodule GitHub.TestingTest do
  use ExUnit.Case
  require GitHub.Testing

  alias GitHub.Testing
  alias GitHub.Repos

  describe "assert_called_gh" do
    test "asserts on the call history of the process" do
      # Testing.assert_called_gh(GitHub.Repos, :get, 2)
      Testing.assert_called_gh_2(Repos.get(:_, :_), times: 2)
    end
  end
end
