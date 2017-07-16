defmodule Myapp do
  use Application

  @doc """
  START Myapp here with arguments

  Examples:

    Myapp.start([], [])
  """

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Myapp.Router, []), # Looks for .start_link function
      worker(Myapp.ApiServer, []) # Now, you don't need to start the GenServer every time
    ]

    options = [
      strategy: :one_for_one, name: Myapp.Supervisor
    ]
    Supervisor.start_link(children, options)
  end
end
