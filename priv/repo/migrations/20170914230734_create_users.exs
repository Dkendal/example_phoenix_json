defmodule ElixirHelloJson.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, engine: :set) do
      add :name, :string

      timestamps()
    end

  end
end
