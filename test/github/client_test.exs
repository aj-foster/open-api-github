defmodule GitHub.ClientTest do
  use ExUnit.Case, async: true
  use GitHub.Testing

  @options [stack: [{GitHub.Plugin.TestClient, :request}]]

  describe "request/1" do
    setup :attach_telemetry

    test "sends start and stop telemetry events" do
      GitHub.Repos.get("aj-foster", "open-api-github", @options)

      assert_received {
        [:oapi_github, :request, :start],
        %{monotonic_time: _, system_time: _},
        %{
          client: GitHub.Client,
          info: %{call: _},
          request_method: :get,
          request_server: "https://api.github.com",
          request_url: "/repos/aj-foster/open-api-github"
        }
      }

      assert_received {
        [:oapi_github, :request, :stop],
        %{duration: _, monotonic_time: _},
        %{
          client: GitHub.Client,
          info: %{call: _},
          request_method: :get,
          request_server: "https://api.github.com",
          request_url: "/repos/aj-foster/open-api-github",
          response_code: 200
        }
      }
    end

    test "sends exception telemetry events" do
      mock_gh &GitHub.Repos.get/2, fn -> raise "Error" end

      assert_raise RuntimeError, fn ->
        GitHub.Repos.get("aj-foster", "open-api-github", @options)
      end

      assert_received {
        [:oapi_github, :request, :exception],
        %{duration: _, monotonic_time: _},
        %{
          client: GitHub.Client,
          info: %{},
          kind: :error,
          reason: %RuntimeError{},
          request_method: :get,
          request_server: "https://api.github.com",
          request_url: "/repos/aj-foster/open-api-github",
          stacktrace: [_ | _]
        }
      }
    end
  end

  defp attach_telemetry(%{describe: describe, test: test}) do
    :telemetry.attach_many(
      "#{describe} #{test}",
      [
        [:oapi_github, :request, :start],
        [:oapi_github, :request, :stop],
        [:oapi_github, :request, :exception]
      ],
      &__MODULE__.handle_event/4,
      nil
    )
  end

  def handle_event(event, measurements, metadata, _config) do
    send(self(), {event, measurements, metadata})
  end
end
