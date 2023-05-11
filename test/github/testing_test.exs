defmodule GitHub.TestingTest do
  use ExUnit.Case
  use GitHub.Testing

  alias ExUnit.AssertionError
  alias GitHub.Repos

  @options [stack: [{GitHub.Plugin.TestClient, :request}]]

  describe "assert_called_gh/2" do
    test "asserts on the call history of the process" do
      # Initial state: no calls

      assert_gh_called Repos.get(:_, :_), times: 0
      assert_gh_called Repos.get("owner", :_), times: 0
      assert_gh_called Repos.get("owner", "repo"), times: 0

      assert_fail(fn -> assert_gh_called Repos.get(:_, :_), times: 1 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", :_), times: 1 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", "repo"), times: 1 end)

      assert_gh_called Repos.get(:_, :_), min: 0
      assert_gh_called Repos.get("owner", :_), min: 0
      assert_gh_called Repos.get("owner", "repo"), min: 0

      assert_fail(fn -> assert_gh_called Repos.get(:_, :_), min: 1 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", :_), min: 1 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", "repo"), min: 1 end)

      assert_gh_called Repos.get(:_, :_), max: 1
      assert_gh_called Repos.get("owner", :_), max: 1
      assert_gh_called Repos.get("owner", "repo"), max: 1

      assert_gh_called Repos.get(:_, :_), min: 0, max: 1
      assert_gh_called Repos.get("owner", :_), min: 0, max: 1
      assert_gh_called Repos.get("owner", "repo"), min: 0, max: 1

      assert_fail(fn -> assert_gh_called Repos.get(:_, :_), min: 1, max: 1 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", :_), min: 1, max: 1 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", "repo"), min: 1, max: 1 end)

      # Alternative form
      assert_gh_called &Repos.get/2, times: 0
      assert_fail(fn -> assert_gh_called &Repos.get/2, times: 1 end)

      # Second state: one call
      Repos.get("owner", "repo", @options)

      assert_gh_called Repos.get(:_, :_), times: 1
      assert_gh_called Repos.get("owner", :_), times: 1
      assert_gh_called Repos.get("owner", "repo"), times: 1

      assert_fail(fn -> assert_gh_called Repos.get(:_, :_), times: 0 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", :_), times: 0 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", "repo"), times: 0 end)

      assert_gh_called Repos.get(:_, :_), min: 0
      assert_gh_called Repos.get("owner", :_), min: 0
      assert_gh_called Repos.get("owner", "repo"), min: 0

      assert_gh_called Repos.get(:_, :_), min: 1
      assert_gh_called Repos.get("owner", :_), min: 1
      assert_gh_called Repos.get("owner", "repo"), min: 1

      assert_fail(fn -> assert_gh_called Repos.get(:_, :_), min: 2 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", :_), min: 2 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", "repo"), min: 2 end)

      assert_gh_called Repos.get(:_, :_), max: 1
      assert_gh_called Repos.get("owner", :_), max: 1
      assert_gh_called Repos.get("owner", "repo"), max: 1

      assert_fail(fn -> assert_gh_called Repos.get(:_, :_), max: 0 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", :_), max: 0 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", "repo"), max: 0 end)

      assert_gh_called Repos.get(:_, :_), min: 0, max: 1
      assert_gh_called Repos.get("owner", :_), min: 0, max: 1
      assert_gh_called Repos.get("owner", "repo"), min: 0, max: 1

      assert_fail(fn -> assert_gh_called Repos.get(:_, :_), min: 2, max: 3 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", :_), min: 2, max: 3 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", "repo"), min: 2, max: 3 end)

      # Third state: different call
      Repos.get("owner", "another-repo", @options)

      assert_gh_called Repos.get(:_, :_), times: 2
      assert_gh_called Repos.get("owner", :_), times: 2
      assert_gh_called Repos.get("owner", "repo"), times: 1

      assert_fail(fn -> assert_gh_called Repos.get(:_, :_), times: 1 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", :_), times: 1 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", "repo"), times: 2 end)

      assert_gh_called Repos.get(:_, :_), min: 2
      assert_gh_called Repos.get("owner", :_), min: 2
      assert_gh_called Repos.get("owner", "repo"), min: 1

      assert_fail(fn -> assert_gh_called Repos.get(:_, :_), min: 3 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", :_), min: 3 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", "repo"), min: 2 end)

      assert_gh_called Repos.get(:_, :_), max: 2
      assert_gh_called Repos.get("owner", :_), max: 2
      assert_gh_called Repos.get("owner", "repo"), max: 1

      assert_fail(fn -> assert_gh_called Repos.get(:_, :_), max: 1 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", :_), max: 1 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", "repo"), max: 0 end)

      assert_gh_called Repos.get(:_, :_), min: 0, max: 2
      assert_gh_called Repos.get("owner", :_), min: 0, max: 2
      assert_gh_called Repos.get("owner", "repo"), min: 0, max: 1

      assert_fail(fn -> assert_gh_called Repos.get(:_, :_), min: 3, max: 4 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", :_), min: 3, max: 4 end)
      assert_fail(fn -> assert_gh_called Repos.get("owner", "repo"), min: 2, max: 3 end)

      # Pinning
      repo = "another-repo"
      assert_gh_called Repos.get(:_, repo)
      assert_fail(fn -> assert_gh_called Repos.get(repo, :_) end)
    end
  end

  defp assert_fail(fun) do
    assert_raise AssertionError, fun
  end
end
