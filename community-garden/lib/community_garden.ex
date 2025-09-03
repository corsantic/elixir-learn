# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(), do: Agent.start(fn -> %{plots: [], next_plot_id: 0} end)

  def start(opts), do: Agent.start(fn -> %{plots: [], next_plot_id: 0} end, opts)

  def list_registrations(pid), do: Agent.get(pid, & &1.plots)

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{plots: plots, next_plot_id: next_plot_id} ->
      plot_id = next_plot_id + 1
      plot = %Plot{plot_id: plot_id, registered_to: register_to}
      {plot, %{plots: [plot | plots], next_plot_id: plot_id}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn %{plots: plots, next_plot_id: next_plot_id} ->
      %{plots: plots |> Enum.filter(&(&1.plot_id != plot_id)), next_plot_id: next_plot_id}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots, next_plot_id: _} ->
      plot = plots |> Enum.find(&(&1.plot_id == plot_id))
      cond do
        plot == nil -> {:not_found, "plot is unregistered"}
        true -> plot
      end
    end)
  end
end
