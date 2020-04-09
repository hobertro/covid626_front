defmodule Covid626Front.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :name, :string
      add :count, :integer

      timestamps()
    end

  end
end
