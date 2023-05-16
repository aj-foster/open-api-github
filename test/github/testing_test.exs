defmodule GitHub.TestingTest do
  use ExUnit.Case
  use GitHub.Testing

  alias ExUnit.AssertionError
  alias GitHub.Repos

  @options [stack: [{GitHub.Plugin.TestClient, :request}]]

  describe "generate_gh/2" do
    test "generates a struct" do
      assert %GitHub.PullRequest{} = generate_gh(GitHub.PullRequest)
      assert %GitHub.User{two_factor_authentication: nil} = generate_gh(GitHub.User, :public)
      assert %GitHub.User{two_factor_authentication: tfa?} = generate_gh(GitHub.User, :private)
      assert is_boolean(tfa?)
    end
  end

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

  describe "mock_gh/3" do
    test "mocks calls for the process" do
      {:ok, %GitHub.Repository{id: id_one}} = Repos.get("owner", "repo", @options)
      id_two = System.unique_integer([:positive])
      id_three = System.unique_integer([:positive])

      mock_gh &Repos.get/2, {:ok, %GitHub.Repository{id: id_two}}

      assert {:ok, %GitHub.Repository{id: ^id_one}} = Repos.get("owner", "repo", @options)
      assert {:ok, %GitHub.Repository{id: ^id_two}} = Repos.get("owner", "repo_two", @options)

      mock_gh Repos.get("owner", "repo"), {:ok, %GitHub.Repository{id: id_three}}

      assert {:ok, %GitHub.Repository{id: ^id_three}} = Repos.get("owner", "repo", @options)
      assert {:ok, %GitHub.Repository{id: ^id_two}} = Repos.get("owner", "repo_two", @options)
    end

    test "mocks using a generator function" do
      mock_gh &Repos.get/2, fn -> {:ok, %GitHub.Repository{id: 12345}} end
      assert {:ok, %GitHub.Repository{id: 12345}} = Repos.get("owner", "repo", @options)

      mock_gh &Repos.list_for_user/1, fn -> {:ok, [%GitHub.Repository{id: 12345}], code: 201} end

      assert {:ok,
              %GitHub.Operation{
                response_body: [%GitHub.Repository{id: 12345}],
                response_code: 201
              }} = GitHub.raw(Repos, :list_for_user, ["me"], @options)
    end

    test "mocks with arguments" do
      mock_gh &Repos.get/2, fn owner, repo ->
        assert owner == "owner"
        assert repo == "repo"
        {:ok, nil}
      end

      assert :ok = Repos.get("owner", "repo", @options)
      assert_fail(fn -> Repos.get("owner", "another-repo", @options) end)
    end

    test "mocks with arguments and options" do
      mock_gh &Repos.get/2, fn owner, _repo, opts ->
        assert owner == "owner"
        assert opts == @options
        {:ok, nil}
      end

      assert :ok = Repos.get("owner", "repo", @options)
      assert_fail(fn -> Repos.get("owner", "another-repo", Keyword.put(@options, :a, :b)) end)
    end
  end

  defp assert_fail(fun) do
    assert_raise AssertionError, fun
  end
end
