# GitHub REST API Client for Elixir

[![Hex.pm](https://img.shields.io/hexpm/v/oapi_github)](https://hex.pm/packages/oapi_github)
[![Documentation](https://img.shields.io/badge/hex-docs-blue)](https://hexdocs.pm/oapi_github)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

_The ergonomics of a hand-crafted client with the API coverage of generated code._

---

This library uses an [OpenAPI Code Generator](https://github.com/aj-foster/open-api-generator) that has the flexibility to wrangle the generated code into an ergonomic client.
So instead of dealing with `NullableRepository` vs. `FullRepository` and other odd artifacts of GitHub's OpenAPI description, there's a predictable interface.

Furthermore, this library has no opinions about what you use for HTTP requests, serialization, etc.
Instead it allows users to define their own **stack** of plugins, many of which are provided here.

## Installation

This library is available on Hex.pm.
Add the dependency in `mix.exs`:

```elixir
def deps do
  [
    {:oapi_github, "~> 0.0.12"}
  ]
end
```

Then install the dependency using `mix deps.get`.

## Configuration

This library comes with a common default set of configuration.
To use it successfully, you will need to install `HTTPoison` and `Jason`.
(Remember, these libraries can easily be switched out by changing the `stack` configuration.
See `GitHub.Config` for more information.)

Some good up-and-running configuration to set:

* `app_name` will include the name of your application in the User Agent so GitHub can contact you if they notice any problems.
* `default_auth` allows you to provide default Authorization header credentials, such as a client ID and secret to increase your rate limit when no other credentials are available.

```elixir
config :oapi_github,
  app_name: "MyApp",
  default_auth: {"client_id", "client_secret"}
```

For more information about configuration, see the documentation for `GitHub.Config`.

## Usage

All of the client operations are generated based on the OpenAPI description provided by GitHub.
In general, you can expect to find:

```elixir
GitHub.Resource.operation(path1, path2, ..., body, opts)
```

Where:

* `Resource` is the name of the resource as tagged by GitHub, like `Repos`.
* `operation` is the name of the route, like `get` or `create_commit_comment`.
* The first arguments are path parameters, such as `owner` and `repo` in `/repos/{owner}/{repo}`.
* If the request accepts a body, then there will be a `body` parameter.
* Finally, all operations accept a keyword list of options.

The options accepted by operations may differ depending on your chosen stack.
However, the following are always available:

* `auth` (string, 2-tuple, or struct implementing `GitHub.Auth`) Credentials to use for the request.
* `server` (URL including scheme) Base API server to use, such as `https://api.github.com` (useful for interacting with GitHub Enterprise installations).
* `version` (string) GitHub API version to use (not recommended to override this, because the generated code may not match the specified version).

Whenever GitHub specifies a named schema as the response type for an operation, an Elixir struct will be returned.
Note that GitHub often has similarly named schemas (such as `SimpleUser`, `PrivateUser`, `PublicUser`, etc.).
Where possible, these have been collapsed into a single struct (like `GitHub.User`) where not all of the fields may be filled in.
However, responses are still properly typed by their type specifications.

## Testing

Test helpers are available in `GitHub.Testing` together with the `GitHub.Plugins.TestClient` plugin.

```elixir
defmodule MyApp.MyTest do
  use ExUnit.Case
  use GitHub.Testing

  test "calls GitHub API" do
    mock_gh &GitHub.Repo.get/2, fn ->
      {:ok, 200, %GitHub.Repository{id: 12345}}
    end

    my_function()

    assert_called_gh GitHub.Repos.get("owner", :_)
  end
end
```

For more information, see the documentation for `GitHub.Testing`.

## Contributing

Because this library uses a code generator for the majority of its mass, there are two modes of contribution.
Please consider these when creating issues or opening pull requests:

* If the generated code is out of date, the fix may be as simple as running `mix gen.api` using the latest OpenAPI description.
* If the client isn't working as expected, the fix may be more involved and require careful thought and versioning.

For more on what this means to you as a contributor, please see the [contribution guidelines](CONTRIBUTING.md).

## Sponsorship

If you like this library or it makes you money, please consider [sponsoring](https://github.com/sponsors/aj-foster).
