defmodule GitHub.Testing do
  @moduledoc """
  Support for interacting with the client in a test environment
  """
  alias GitHub.Operation

  @doc """
  Generate random data for use in a test response

  This function uses randomness to help avoid collisions in tests. It also supports special cases
  based on the context of the generated data (the schema and/or key). Examples can be found in the
  **Special Cases** section below.

  ## Special Cases

  * `:id` fields with type `:integer` will have unique positive integers rather than the limited
    range of integers returned by a typical `:integer` field.

  * `:string` fields with keys that end with `_at` will have ISO 8601 datetime strings from a
    random time within the past day.

  * `:string` fields with keys named `:url` or that end with `_url` will have random URL strings.

  Additional special cases can be added to make the generated data more typical of real responses.
  For example, returning a name-like string for user names, and limiting the allowed characters
  for usernames.

  > #### Note {:.info}
  >
  > If you see an opportunity to improve the generated data for a particular field, please include
  > the description of the field from
  > [GitHub's OpenAPI specification](https://github.com/github/rest-api-description)
  > in your pull request.

  ## Examples

      iex> GitHub.Testing.generate(nil, nil, {GitHub.Repository, :full})
      %GitHub.Repository{...}

      iex> GitHub.Testing.generate(GitHub.Repository, :id, :integer)
      226194162

  """
  @spec generate(module, atom, Operation.type()) :: any
  def generate(schema, key, type)

  # Special cases
  def generate(_schema, :email, :string), do: Faker.Internet.email()
  def generate(_schema, :id, :integer), do: System.unique_integer([:positive])
  def generate(_schema, :login, :string), do: Faker.Internet.user_name()
  def generate(_schema, :name, :string), do: Faker.Person.name()
  def generate(_schema, :url, :string), do: Faker.Internet.url()

  # Primitive types
  def generate(_schema, _key, :binary), do: Faker.String.base64()
  def generate(_schema, _key, :boolean), do: Enum.random([true, false])
  def generate(_schema, _key, :integer), do: Enum.random(1..10)
  def generate(_schema, _key, :map), do: %{}

  def generate(_schema, _key, :number) do
    Enum.random([
      fn -> Enum.random(1..10) end,
      fn -> Faker.random_uniform() * 10 end
    ]).()
  end

  def generate(_schema, key, :string) do
    string_key = Atom.to_string(key)

    cond do
      String.ends_with?(string_key, "_at") ->
        now = DateTime.utc_now()
        yesterday = DateTime.add(now, -1, :day)

        Faker.DateTime.between(yesterday, now)
        |> DateTime.to_iso8601()

      String.ends_with?(string_key, "_url") ->
        Faker.Internet.url()

      :else ->
        Faker.Lorem.characters() |> to_string()
    end
  end

  def generate(_schema, _key, :null), do: nil
  def generate(_schema, _key, :unknown), do: nil

  # Compound types
  def generate(schema, key, {:array, type}), do: generate(schema, key, type)

  def generate(schema, key, {:union, types}) do
    Enum.map(types, fn type ->
      fn -> generate(schema, key, type) end
    end)
    |> Enum.random()
    |> apply([])
  end

  def generate(schema, key, {:nullable, type}) do
    Enum.random([
      fn -> nil end,
      fn -> generate(schema, key, type) end
    ]).()
  end

  def generate(_schema, _key, {module, struct_type}) do
    apply(module, :__fields__, [struct_type])
    |> Enum.map(fn {key, field_type} -> {key, generate(module, key, field_type)} end)
    |> then(fn fields -> struct!(module, fields) end)
  end
end
