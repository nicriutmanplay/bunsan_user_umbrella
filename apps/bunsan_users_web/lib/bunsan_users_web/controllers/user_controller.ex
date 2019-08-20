defmodule BunsanUsersWeb.UserController do
  use BunsanUsersWeb, :controller
  alias BunsanUsers.User

  action_fallback(BunsanUsersWeb.UserFallBackController)

  def create(conn, %{"user" => user_params}) do
    chg = User.signup_changeset(%User{}, user_params)
    case chg.valid? do
      true ->
        {:ok, user} = User.save(chg)
        conn
          |> put_status(201)
          |> render("user.json", %{user: user})
      false ->
        {:error, chg}
    end
  end

  def index(conn, _params) do
    users = User.search_all
    conn
      |> put_status(200)
      |> render("users.json", %{users: users})
  end

  def show(conn, %{"id" => user_id}) do
    case User.search(user_id) do
      nil ->
        {:error, "user_not_fout"}
      user ->
        conn
          |> put_status(200)
          |> render("user.json", %{user: user})
    end
  end
end
