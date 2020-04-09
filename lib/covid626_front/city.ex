defmodule Covid626Front.City do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cities" do
    field :count, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, [:name, :count])
    |> validate_required([:name, :count])
  end
end
