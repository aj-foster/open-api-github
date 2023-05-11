locals_without_parens = [
  # GitHub.Testing
  assert_gh_called: 1,
  assert_gh_called: 2
]

[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: locals_without_parens
]
