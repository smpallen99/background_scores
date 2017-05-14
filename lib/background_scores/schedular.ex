defmodule BackgroundScores.Scheduler do
  use GenServer
  require Logger

  @sample_users ~w(user1 user2 deathray user3 elixirchamp steve other)a

  ##########
  # Public API
  def start_link(args) do
    GenServer.start_link __MODULE__, args, name: __MODULE__
  end

  def get_scores do
    GenServer.call __MODULE__, :get_scores
  end

  #########
  # Call backs

  def init(args) do
    period = args[:period] || 30 * 1000
    Process.send_after self(), :run_task, 1000
    {:ok, %{period: period, scores: []} }
  end

  def handle_call(:get_scores, _, state) do
    {:reply, state[:scores], state}
  end

  def handle_info(:run_task, state) do
    Process.send_after self(), :run_task, state[:period]
    {:noreply, run_command(state)}
  end

  ############
  # Private helpers

  defp run_command(%{scores: scores} = state) do
    poll_scores()
    |> compare_scores(scores)
    |> notify_client
    |> update_state(state)
  end

  defp poll_scores do
    # Simulate the results of fetching scores from an external API
    count = :random.uniform 3
    users =
      for _ <- 1..count do
        Enum.random @sample_users
      end
    # Turn the users and scores into a Keyword list. username is the key
    Enum.zip(users, random_scores(count))
  end

  defp random_scores(count) do
    for _ <- 1..count, do: :random.uniform(10)
  end

  defp compare_scores(new_scores, old_scores) do
    {Keyword.equal?(new_scores, old_scores), new_scores, old_scores}
  end

  defp notify_client({true, _, old_scores}) do
    # no change
    old_scores
  end
  defp notify_client({false, new_scores, old_scores}) do
    # this is where you will call your channel to update the scores

    # Channel data must be a map. So convert the keyword list into a map
    BackgroundScores.Endpoint.broadcast! "scores:lobby", "update", Enum.into(new_scores, %{})
     
    new_scores
  end

  defp update_state(scores, state), do: Map.put(state, :scores, scores)

end
