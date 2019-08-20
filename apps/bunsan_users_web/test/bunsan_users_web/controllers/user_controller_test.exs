defmodule BunsanUsersWeb.UserControllerTest do
  use BunsanUsersWeb.ConnCase

  setup do
    user = %BunsanUsers.User{}
    user_chg = BunsanUsers.User.signup_changeset(user, %{"name" => "julio", "age" => 33, "email" => "nicri@gmail.com"})
    stored_user = BunsanUsers.Repo.insert!(user_chg)
    {:ok, user: stored_user}
  end

  test "user creation succesfullu" do
    conn = build_conn()
      |> put_req_headers("content-type", "application/json")
      |> post("/api/v1/users", create_user_request_body())
    conn
      |> response(201)
  end

  test "find user test", %{user: user} do
    conn = buil_conn()
      |> get("/api/v1/users/#{user.id}")
    conn
      |>response(200)
  end

  def create_user_request_body do
    ~s({
      "user":{
        "name": "brandon",
        "email": "nicri@gmail.com",
        "age": 25
      }
    })
  end
end
