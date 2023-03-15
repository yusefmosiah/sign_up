defmodule User do
  @moduledoc """
  Documentation for `User`

  Defines a schemaless changeset and `User` struct.

  ## Examples

      iex> %User{}
      %User{username: nil, password: nil, age: nil, birthdate: nil, terms_and_conditions: nil}
  """
  defstruct [:username, :password, :terms_and_conditions, :age, :birthdate]

  @types %{
    username: :string,
    password: :string,
    age: :integer,
    birthdate: :date,
    terms_and_conditions: :boolean
  }

  @doc """
  Create a User changeset.

  ## Examples

      iex> User.changeset(%User{}, %{username: "user1", password: "securepassword1", age: 20, terms_and_conditions: true})
      #Ecto.Changeset<action: nil, changes: %{age: 20, password: "securepassword1", terms_and_conditions: true, username: "user1"}, errors: [], data: #User<>, valid?: true>
  """
  def changeset(%__MODULE__{} = user \\ %__MODULE__{}, params) do
    {user, @types}
    |> Ecto.Changeset.cast(params, Map.keys(@types))
    |> Ecto.Changeset.validate_required([:username, :password])
    |> Ecto.Changeset.validate_required(:terms_and_conditions)
    |> Ecto.Changeset.validate_length(:username, min: 3, max: 12)
    |> Ecto.Changeset.validate_length(:password, min: 12, max: 50)
    |> Ecto.Changeset.validate_acceptance(:terms_and_conditions)
  end

  @doc """
  Validate and create a User struct.

  ## Examples

      iex> User.new(%{username: "user1", password: "securepassword1", age: 20, terms_and_conditions: true})
      {:ok, %User{username: "user1", password: "securepassword1", age: 20, terms_and_conditions: true}}

      Terms and conditions must be signed.

      User.new(%{username: "user1", password: "securepassword1", age: 20, terms_and_conditions: false})
      {:error, _changeset}
  """
  def new(params) do
    changeset(params)
    |> Ecto.Changeset.apply_action(:update)
  end
end
