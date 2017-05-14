defmodule BackgroundScores.Scores do
  alias BackgroundScores.{Repo, Score}

  require Logger

  @sample_users ~w(user1 user2 deathray user3 elixirchamp steve other)

  def fetch_scores do
    score_schema = Score.get_scores() |> Repo.one 
    poll_scores()
    |> compare_scores(score_schema.scores)
    |> notify_client
    |> update_scores(score_schema)
  end

  defp poll_scores do
    # Simulate the results of fetching scores from an external API
    count = :random.uniform 3
    users =
      for _ <- 1..count do
        Enum.random @sample_users
      end
    # Turn the users and scores into a Keyword list. username is the key
    Enum.zip(users, random_scores(count)) |> Enum.into(%{})
  end

  defp random_scores(count) do
    for _ <- 1..count, do: :random.uniform(10)
  end

  defp compare_scores(new_scores, old_scores) do
    Logger.debug "compare_scores: new_scores: #{inspect new_scores}, old_scores: #{inspect old_scores}"
    {Map.equal?(new_scores, old_scores), new_scores, old_scores}
  end

  defp notify_client({true, _, old_scores}) do
    # no change
    old_scores
  end
  defp notify_client({false, new_scores, _old_scores}) do
    # this is where you will call your channel to update the scores

    BackgroundScores.Endpoint.broadcast! "scores:lobby", "update", new_scores
     
    new_scores
  end
  defp update_scores(scores, score_schema) do
    Repo.update! Score.changeset(score_schema, %{scores: scores})
  end

end