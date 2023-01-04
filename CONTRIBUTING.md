# Contribution Guidelines

Hello there.
Thank you for your interest in contributing to this project.
GitHub has a large API that would be impossible to maintain a client for without help.

Reading and following the guidelines in this document is an act of kindness and respect for other contributors.
With your help, we can address issues, make changes, and work together efficiently.

## Ways to Contribute

There are many ways to contribute to this project:

* Anyone can use the `mix api.gen` task (see below) to update the library using the latest OpenAPI description.
* Users of the client can report issues related to the client itself and propose solutions.
* Users and library authors can contribute plugins (see below) for new integrations.
* Everyone can help improve documentation and support others in Discussions.
* Anyone can assist in the triage of bugs, identifying root causes, and proposing solutions.

Please keep in mind the intended scope of this package: to provide a GitHub REST API client that balances an ergonomic user experience with the maintainability of code generation.
Assume that the GitHub OpenAPI description that serves as input to this library will change often, and manually changing the output is impractical.

## Ground Rules

All contributions to this project must align with the [code of conduct](CODE_OF_CONDUCT.md).
Beyond that, we ask:

* Please be kind. Maintaining this project is not paid work.
* Please create an issue before embarking on major refactors or new features.
* Let's make a reasonable effort to support commonly-used 3rd-party integrations.

## Workflows

If you're interested in doing something specific, here are some guidelines:

### Security Issues

If you find a security-related issue with this project, please refrain from opening a public issue and instead [email the maintainer](mailto:public@aj-foster.com).

### Bugs and Blockers

Please use [GitHub Issues](https://github.com/aj-foster/open-api-github/issues) to report reproducible bugs.

### Feature Requests and Ideas

Please use [GitHub Discussions](https://github.com/aj-foster/open-api-github/discussions) to share requests and ideas for improvements to the library.

### Updating the Generated Code

If you intend to open a PR with updates to the generated code based on the latest GitHub OpenAPI description, please read carefully:

1. Please use the latest commit from the [official repository](https://github.com/github/rest-api-description) at the time of your contribution.
2. Please use `descriptions/api.github.com/api.github.com.yaml` — **not** `descriptions-next` or a GitHub Enterprise release.
3. Use `mix api.gen default path/to/descriptions/api.github.com/api.github.com.yaml` to regenerate the code.
4. Please include the commit SHA of the official repository in the description of your pull request.
5. Please do not make any other changes in the same PR (for example, changing the library version).

If you run into any unexpected issues while generating the code, please open an issue.

Thank you for you help!

### Implementing Changes

If you've decided to take on the implementation of a new feature or fix, please remember to avoid changing files in `operations/` and `schemas/`.
These directories contain generated code, and therefore will be overwritten.
If something in there needs to be changed, please start a discussion on [the generator repo](https://github.com/aj-foster/open-api-generator).
