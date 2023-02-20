# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

* **Breaking**: Upgrade to OpenAPI 3.1 description (`descriptions-next`) with better support for nullable fields.
  No more `.nullable()` types!
* **Add**: Upgrade to `oapi_generator` version `0.0.2`, with support for OpenAPI 3.1 and other fixes.
* **Add**: Upgrade to `oapi_generator` version `0.0.3`, with support for `args` passed to the client.
* **Add**: Include the recommended API version header in all requests.
  The value of this header is defined by the `.api-version` file, which should be kept up-to-date
  as the code is regenerated.
* **Add**: Plugin for caching redirect locations to avoid repeated (rate limited) 301 responses.

### 0.0.1

* **Initial Release**
