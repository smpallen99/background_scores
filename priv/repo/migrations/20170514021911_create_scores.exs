defmodule BackgroundScores.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :scores, :map
    end
  end
end
