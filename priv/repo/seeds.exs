# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BackgroundScores.Repo.insert!(%BackgroundScores.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.
alias BackgroundScores.{Repo, Score}

Repo.delete_all Score
Repo.insert! Score.changeset(%Score{}, %{scores: %{}})

