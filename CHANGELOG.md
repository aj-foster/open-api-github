# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

_Nothing yet._

### 0.0.10 (2023-05-18)

* **Add**: New `__info__` key on every struct to contain library and plugin data.
* **Add**: Preserve important response headers in `GitHub.Plugin.RedixFullResponseCache`.

### 0.0.9 (2023-05-17)

* **Add**: Generated data from `GitHub.Testing.generate_gh/3` now accepts optional overrides.
* **Fix**: Include formatter configuration in published package.
  This allows use of `mock_gh` and other imported test helpers without parens.

### 0.0.8 (2023-05-16)

* **Fix**: Correctly generate array types using single element lists in `GitHub.Testing`.

### 0.0.7 (2023-05-16)

* **Add**: Support lists of servers in both Redix-based plugins.
* **Add**: Correctly decode repository rule unions in `GitHub.Plugin.TypedDecoder`.
* **Fix**: Correctly decode array types in `GitHub.Plugin.TypedDecoder`.

### 0.0.6 (2023-05-16)

* **Breaking**: Perform major housecleaning on module naming, groups, etc.
  Most notable is the merging of `Team.Full` to `Team` and `MinimalRepository` to `Repository`.
  Several schemas have been placed into better groups, and some have been moved (for example, `Job` is now `Actions.Job`).
  Not all changes are documented here because this library is in early beta and this type of movement is expected.
* **Breaking**: Update to the latest version of the API description, which removes several operations and adds several schemas.
* **Add**: Simplified `generate_gh/2` helper in `GitHub.Testing` for generating structs.
* **Add**: Upgrade to `oapi_generator` version `0.0.5` with support for null unions, as found in the latest API description.

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
