# BackgroundScores

Sample project for running a background task within a phoenix project.

This version uses the [Quantum](https://hex.pm/packages/quantum) package to scheule the scores fetch task.

The old scores are stored in a database.

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate && mix run priv/repo/seeds.exs`
  * Make sure you run the seeds file above. The application needs the seeds run.
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

You should the scores updated once a minute. To change this interval, edit the [config/config.exs](config/config.exs) file.
