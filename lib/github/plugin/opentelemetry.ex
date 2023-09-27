if Code.ensure_loaded?(:opentelemetry) do
  defmodule GitHub.Plugin.OpenTelemetry do
    @moduledoc """
    OpenTelemetry bindings for all operation requests

    This module provides an easy way to report GitHub operations to OpenTelemetry. The library
    has built-in support for Erlang telemetry in the default client `GitHub.Client`. This module
    attaches to the available telemetry events and manages OpenTelemetry tracing.

    ## Usage

    This module requires the following optional dependencies to be included in `mix.exs`:

        {:opentelemetry_api, "~> 1.0"},
        {:opentelemetry_semantic_conventions, "~> 0.2"}

    Unlike other plugins, this does not get included in the client stack. Instead, include it in
    your main `Application` module start:

        def start(_type, _args) do
          GitHub.Plugin.OpenTelemetry.setup()

          # ...
        end

    """

    alias OpenTelemetry.SemanticConventions.Trace

    require Trace
    require OpenTelemetry.Tracer

    @doc """
    Initialize Erlang telemetry handlers to produce OpenTelemetry traces
    """
    @spec setup(keyword) :: :ok
    def setup(_opts \\ []) do
      :telemetry.attach(
        {__MODULE__, :request_stop},
        [:oapi_github, :request, :stop],
        &__MODULE__.handle_request_stop/4,
        %{}
      )

      :telemetry.attach(
        {__MODULE__, :request_exception},
        [:oapi_github, :request, :exception],
        &__MODULE__.handle_request_exception/4,
        %{}
      )
    end

    @doc false
    def handle_request_stop(_event, measurements, metadata, _config) do
      %{duration: duration, monotonic_time: end_time} = measurements

      %{
        info: %{call: {call_module, call_function}},
        request_method: request_method,
        request_server: request_server,
        request_url: request_url,
        response_code: response_code
      } = metadata

      uri = Path.join(request_server, request_url) |> URI.parse()
      start_time = end_time - duration

      attributes = %{
        Trace.code_namespace() => call_module,
        Trace.code_function() => call_function,
        Trace.http_url() => URI.to_string(uri),
        Trace.http_scheme() => uri.scheme,
        Trace.net_peer_name() => uri.host,
        Trace.net_peer_port() => uri.port,
        Trace.http_target() => uri.path,
        Trace.http_method() => request_method,
        Trace.http_status_code() => response_code
      }

      s =
        OpenTelemetry.Tracer.start_span("#{inspect(call_module)}.#{call_function}", %{
          start_time: start_time,
          attributes: attributes,
          kind: :client
        })

      if metadata[:error] do
        OpenTelemetry.Span.set_status(
          s,
          OpenTelemetry.status(:error, to_string(metadata[:error]))
        )
      end

      OpenTelemetry.Span.end_span(s)
    end

    @doc false
    def handle_request_exception(_event, measurements, metadata, _config) do
      %{duration: duration, monotonic_time: end_time} = measurements

      %{
        info: %{call: {call_module, call_function}},
        kind: kind,
        reason: reason,
        request_method: request_method,
        request_server: request_server,
        request_url: request_url,
        stacktrace: stacktrace
      } = metadata

      uri = Path.join(request_server, request_url) |> URI.parse()
      start_time = end_time - duration

      message =
        case kind do
          :exit -> "Process exit"
          :error -> Exception.message(reason)
          :throw -> "Thrown value"
        end

      attributes = %{
        Trace.code_namespace() => call_module,
        Trace.code_function() => call_function,
        Trace.exception_escaped() => true,
        Trace.exception_message() => message,
        Trace.exception_stacktrace() => stacktrace,
        Trace.http_url() => URI.to_string(uri),
        Trace.http_scheme() => uri.scheme,
        Trace.net_peer_name() => uri.host,
        Trace.net_peer_port() => uri.port,
        Trace.http_target() => uri.path,
        Trace.http_method() => request_method
      }

      s =
        OpenTelemetry.Tracer.start_span("#{inspect(call_module)}#{call_function}", %{
          start_time: start_time,
          attributes: attributes,
          kind: :client
        })

      OpenTelemetry.Span.set_status(
        s,
        OpenTelemetry.status(:error, inspect(metadata[:reason]))
      )

      OpenTelemetry.Span.end_span(s)
    end
  end
end
