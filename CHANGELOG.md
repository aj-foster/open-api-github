# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

* **Add**: Simplified `generate_gh/2` helper in `GitHub.Testing` for generating structs.

### 0.0.5 (2023-05-12)

* **Breaking**: `GitHub.Plugin.TypedDecoder` now normalizes errors for all status codes greater than or equal to `400`.
  Previously, errors were only normalized when the operation had well-typed errors in its response specification.
  This left out a large number of errors, including many "Not Found" errors that did not need to be documented for every operation.
  For a list of supported errors, see `GitHub.Error`.
* **Add**: `GitHub.Error` structs now have an easily matchable `reason` field.
  This field will need to be populated on a case-by-case basis in `GitHub.Plugin.TypedDecoder`.
* **Fix**: Return valid user `type` values from the test generator.

### 0.0.4 (2023-05-12)

* **Breaking**: The mock system has been rewritten to allow greater flexibility.
  See `GitHub.Testing` for more information.
* **Add**: Add helper `GitHub.Operation.get_options/1` for plugins and testing.
* **Fix**: Export "locals without parens" to allow using test helpers without parentheses.

### 0.0.3 (2023-05-11)

* **Add**: Decode union types in `GitHub.Plugin.TypedDecoder` using best-guess logic.
  This enhancement supports all currently-known union type responses, but it will require long-term maintenance.
* **Add**: Allow returning unwrapped results from client operations.
  This can be useful for callers that need more information, such as response headers.

* **Fix**: Support zero-arity operations in `GitHub.Operation.get_caller/1`.

### 0.0.2 (2023-05-11)

* **Breaking**: Upgrade to OpenAPI 3.1 description (`descriptions-next`) with better support for nullable fields.
  No more `.nullable()` types!
* **Add**: Upgrade to `oapi_generator` version `0.0.2`, with support for OpenAPI 3.1 and other fixes.
* **Add**: Upgrade to `oapi_generator` version `0.0.3`, with support for `args` passed to the client.
* **Add**: Upgrade to `oapi_generator` version `0.0.4`, with support for `call` passed to the client.
* **Add**: Include the recommended API version header in all requests.
  The value of this header is defined by the `.api-version` file, which should be kept up-to-date
  as the code is regenerated.
* **Add**: Plugin for caching redirect locations to avoid repeated (rate limited) 301 responses.
* **Add**: Test helpers in `GitHub.Testing` and corresponding plugin `GitHub.Plugins.TestClient`.
* **Add**: Allow setting the client stack at runtime.

### 0.0.1 (2023-01-05)

* **Initial Release**
