defmodule TakeANumberDeluxe do
  alias TakeANumberDeluxe.State
  use GenServer
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_args) do
    GenServer.start_link(__MODULE__, init_args)
  end

  @spec report_state(pid()) :: State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks
  @impl GenServer
  def init(init_args) do
    min = Keyword.get(init_args, :min_number)
    max = Keyword.get(init_args, :max_number)
    timeout = Keyword.get(init_args, :auto_shutdown_timeout, :infinity)

    _init_state(min, max, timeout)
  end

  # init can be done like below with using `with`
  #  def init(init_args) do
  #   with min <- Keyword.get(init_args, :min_number),
  #        max <- Keyword.get(init_args, :max_number),
  #        shutdown <- Keyword.get(init_args, :auto_shutdown_timeout, :infinity),
  #        {:ok, state} <- TakeANumberDeluxe.State.new(min, max, shutdown) do
  #     {:ok, state, shutdown}
  #   else
  #     _ -> {:stop, :invalid_configuration}
  #   end
  # end 

  defp _init_state(min, max, timeout) do
    result = State.new(min, max, timeout)

    case result do
      {:ok, state} -> {:ok, state, timeout}
      {:error, reason} -> {:stop, reason}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, %State{} = state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, %State{} = state) do
    result = State.queue_new_number(state)

    case result do
      {:ok, next_available_number, new_state} ->
        {:reply, {:ok, next_available_number}, new_state, new_state.auto_shutdown_timeout}

      {:error, reason} ->
        {:reply, {:error, reason}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, %State{} = state) do
    result = State.serve_next_queued_number(state, priority_number)

    case result do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state, new_state.auto_shutdown_timeout}

      {:error, reason} ->
        {:reply, {:error, reason}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  @spec handle_cast(:reset_state, State.t()) ::
          {:noreply, State.t(), any()}
  def handle_cast(:reset_state, %State{} = state) do
    {:ok, new_state, timeout} =
      _init_state(state.min_number, state.max_number, state.auto_shutdown_timeout)

    {:noreply, new_state, timeout}
  end

  @impl GenServer
  def handle_info(:timeout, %State{} = state) do
    {:stop, :normal, state}
  end

  @impl GenServer
  @spec handle_info(any(), State.t()) ::
          {:noreply, State.t(), atom()}
  def handle_info(_, %State{} = state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
