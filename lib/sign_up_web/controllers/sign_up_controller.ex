defmodule SignUpWeb.SignUpController do
  use SignUpWeb, :controller

  def create(conn, params) do
    IO.inspect(conn.params |> Map.keys(), label: "conn.params |> Map.keys()")
    IO.inspect(coerce(conn.params), label: "coerced params")

    changeset = coerce(conn.params)

    # case SignUp.User.new(params) do
    #   {:ok, user} ->
    #     conn
    #     |> put_flash(:info, "Welcome, #{user.name}!")
    #     |> redirect(to: Routes.page_path(conn, :index))

    #   {:error, changeset} ->
    #     render(conn, "sign_up.html", changeset: changeset)
    # end

    render(conn, "sign_up.html", changeset: changeset)
  end

  def coerce(params) do
    params =
      for {param_key, param_value} <- params, param_key != "_csrf_token", into: %{} do
        {String.to_existing_atom(param_key), param_value}
      end

    %{
      params
      | age: String.to_integer(params["age"]),
        birthdate: Date.from_iso8601(params["birthdate"]),
        terms_and_conditions: String.to_existing_atom(params["terms_and_conditions"])
    }
    |> IO.inspect(label: "coerced params")

    # |> Map.put("name", params["name"] |> String.trim())
    # |> Map.put("email", params["email"] |> String.trim())
    # |> Map.put("password", params["password"] |> String.trim())
  end
end
