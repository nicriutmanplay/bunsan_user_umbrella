defmodule BunsanUsersWeb.UserFallBackController do
  use BunsanUsersWeb, :controller

  def call(conn, {:error, changeset = %Ecto.Changeset{}}) do
    conn
      |> put_status(400)
      |> json(%{error: "changeset errors"})
  end

  def call(conn, {:error, error}) do
    conn
      |> put_status(404)
      |> json(%{error: error})
  end

  def call(conn, _) do
    conn
      |> put_status(500)
      |> json(%{error: "unhandle error: please call Bunsan"})
  end
end
