defmodule BunsanUsers.UserTest do
  use BunsanUsers.DataCase

  setup do
    user = %BunsanUsers.User{}
    user_chg = BunsanUsers.User.signup_changeset(user, %{"name" => "julio", "age" => 33, "email" => "nicri@gmail.com"})
    stored_user = BunsanUsers.Repo.insert!(user_chg)
    {:ok, user: stored_user}
  end

  test "create user succesfully" do
    user = %BunsanUsers.User{}
    changeset = BunsanUsers.User.signup_changeset(user, %{name: "misael", age: 33, email: "nicri@gmail.com"})
    assert changeset.valid? == true
    {:ok, _} = BunsanUsers.User.save(changeset)
  end
  test "create user unsuccesfully" do
    user = %BunsanUsers.User{}
    changeset = BunsanUsers.User.signup_changeset(user, %{name: "misael", age: "a", email: "nicri@gmail.com"})
    assert changeset.valid? == false
  end

  test "search user succesfully", %{user: user} do
    user = BunsanUsers.User.search(user.id)
    assert user.name == "julio"
  end

  test "search all users" do
    users = BunsanUsers.User.search_all
    assert users != []
  end
end
