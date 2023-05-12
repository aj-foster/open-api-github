locals_without_parens = [
  # GitHub.Testing
  assert_gh_called: 1,
  assert_gh_called: 2,
  mock_gh: 2,
  mock_gh: 3
]

[
  export: [locals_without_parens: locals_without_parens],
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: locals_without_parens
]
