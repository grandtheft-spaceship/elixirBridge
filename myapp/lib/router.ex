defmodule Myapp.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  # The arguments you pass to start_link depend on what you passed as the children in the Supervisor
  def start_link() do
    {:ok, _} = Plug.Adapters.Cowboy.http(Myapp.Router, [], [port: 4000])
  end

  get "/" do
    {:ok, pokemon} = Myapp.ApiServer.get_pokemon()

    locals = [
      name: "Justin",
      pokemon: pokemon
    ]

    page = EEx.eval_file("templates/home.html", locals)

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, page)
  end

  get "/hello" do
    conn
    |> put_resp_header("content-type", "text/html")
    |> send_resp(200, "Hello!")
  end


# Matches any kind of request: GET, POST, PUT...
  match _ do

  conn # Whenever a connection is available, the conn variable will also be accessible
    |> send_resp(404, "Not Found")
    |> halt
  end
end
