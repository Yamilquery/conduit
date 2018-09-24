defmodule Conduit.Mixfile do
  use Mix.Project

  def project do
    [
      app: :conduit,
      version: "0.0.1",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
    ]
  end

  def application do
    [
      mod: {Conduit.Application, []},
      extra_applications: [
        :absinthe,
        :logger,
        :runtime_tools,
        :eventstore,
      ],
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:absinthe, "~> 1.4.9"},
      {:absinthe_ecto, "~> 0.1.3"},
      {:absinthe_phoenix, "~> 1.4.0"},
      {:absinthe_plug, "~> 1.4.0"},
      {:bcrypt_elixir, "~> 1.0"},
      {:comeonin, "~> 4.0"},
      {:commanded, "0.16.0", override: true},
      {:commanded_ecto_projections, "~> 0.6"},
      {:commanded_eventstore_adapter, "0.4.0"},
      {:cors_plug, "~> 1.4"},
      {:cowboy, "~> 1.0"},
      {:exconstructor, "~> 1.1"},
      {:ex_machina, "~> 2.1", only: :test},
      {:gettext, "~> 0.11"},
      {:guardian, "~> 0.14"},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:phoenix, "~> 1.3"},
      {:phoenix_ecto, "~> 3.3"},
      {:postgrex, ">= 0.0.0"},
      {:slugger, "~> 0.2"},
      {:uuid, "~> 1.1"},
      {:vex, "~> 0.6"},
    ]
  end

  defp aliases do
    [
      "event_store.reset": ["event_store.drop", "event_store.create", "event_store.init"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"],
    ]
  end
end
