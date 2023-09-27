# Telemetry

This library provides Erlang [Telemetry](`:telemetry`) events for all operation requests to the default client using the prefix `[:oapi_github, :request]`.

## Events

There is one set of events that covers all possible operations:

### `[:oapi_github, :request, :start]`

Measurements:

* `:monotonic_time`: (integer) monotonic system time in native time units from `:erlang.monotonic_time/0`
* `:system_time`: (integer) current system time in native time units from `:erlang.system_time/0`

Metadata:

* `:client`: (module) client module originally called
* `:info`: (map) all information provided to the client's `request/1` function
* `:request_method`: (atom) HTTP method of the call
* `:request_server`: (string) hostname of the API server
* `:request_url`: (string) API endpoint

### `[:oapi_github, :request, :stop]`

Measurements:

* `:duration`: (integer) duration of the call in native time units using monotonic times
* `:monotonic_time`: (integer) monotonic system time in native time units from `:erlang.monotonic_time/0`

Metadata:

* `:error`: (atom) if the result of the call was an error (but not an exception), the reason for the error
* `:response_code`: (integer) HTTP status code of the response, if one was received
* All metadata from the `:start` event

### `[:oapi_github, :request, :exception]`

Measurements:

* `:duration`: (integer) duration of the call in native time units using monotonic times
* `:monotonic_time`: (integer) monotonic system time in native time units from `:erlang.monotonic_time/0`

Metadata:

* `:kind`: (atom) one of `:throw`, `:error`, or `:exit` based on the type of exception
* `:reason`: (any) cause of the exception
* `:response_code`: (integer) HTTP status code of the response, if one was received
* `:stacktrace`: (list of tuples) stacktrace of the exception
* All metadata from the `:start` event
