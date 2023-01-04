defmodule GitHub.OperationTest do
  use ExUnit.Case

  alias GitHub.Operation

  describe "new/1" do
    setup do
      %{
        info: %{
          url: "/repos/aj-foster/open-api-github",
          method: :get,
          response: [{200, {GitHub.Repository, :full}}],
          opts: []
        }
      }
    end

    test "includes default auth header", %{info: info} do
      operation = Operation.new(info)
      default_auth = Base.encode64("client_one:abc123")

      assert Enum.find(operation.request_headers, fn {name, value} ->
               name == "Authorization" and
                 value == "Basic #{default_auth}"
             end)
    end

    test "includes custom auth header", %{info: info} do
      operation = Operation.new(%{info | opts: [auth: "abc123"]})

      assert Enum.find(operation.request_headers, fn {name, value} ->
               name == "Authorization" and
                 value == "Bearer abc123"
             end)
    end

    test "includes content type", %{info: info} do
      operation = Operation.new(Map.put(info, :request, [{"application/json", nil}]))

      assert Enum.find(operation.request_headers, fn {name, value} ->
               name == "Content-Type" and
                 value == "application/json"
             end)
    end

    test "includes user agent", %{info: info} do
      operation = Operation.new(info)

      assert Enum.find(operation.request_headers, fn {name, value} ->
               name == "User-Agent" and
                 value =~ "via oapi_github"
             end)
    end
  end
end
