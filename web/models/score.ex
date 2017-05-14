defmodule BackgroundScores.Score do
  use BackgroundScores.Web, :model
  import Ecto.Query
  

  schema "scores" do
    field :scores, :map
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:scores])
    |> validate_required([:scores])
  end

  def get_scores do
    from s in __MODULE__, limit: 1
  end
end