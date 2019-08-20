defmodule BunsanUsers.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    timestamps()
  end

  def signup_changeset(user = %BunsanUsers.User{}, params) do
    user
      |> cast(params, [:name, :age, :email])
      |> validate_required([:name, :age, :email])
  end

  def save(changeset) do
    BunsanUsers.Repo.insert(changeset)
  end

  def search(user_id) do
    query = from u in BunsanUsers.User,
            where: u.id == ^user_id,
            select: u
            #%{id: u.id, name: u.name, age: u.age, email: u.email}
    BunsanUsers.Repo.one(query)
  end

  def search_all do
    query = from u in BunsanUsers.User,
            select: u
    BunsanUsers.Repo.all(query)
  end

end
