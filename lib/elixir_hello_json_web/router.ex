defmodule ElixirHelloJsonWeb.Router do
  use ElixirHelloJsonWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirHelloJsonWeb do
    pipe_through :api
  end
end
