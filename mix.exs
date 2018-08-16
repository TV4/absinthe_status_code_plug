defmodule AbsintheStatusCodePlug.MixProject do
  use Mix.Project

  def project do
    [
      app: :absinthe_status_code_plug,
      version: "1.0.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:plug, "~> 1.6"},
      {:jason, "~> 1.1"}
    ]
  end
end
