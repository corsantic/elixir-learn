defmodule TakeANumber do
  def start() do
    spawn(&loop/0)
  end

  defp loop(state \\ 0) do
    IO.inspect(state)

    receive do
      :stop ->
        Kernel.exit(:killed)

      {:report_state, sender_id} ->
        send(sender_id, state)
        loop(state)

      {:take_a_number, sender_id} ->
        send(sender_id, state + 1)
        loop(state + 1)

      _ ->
        loop(state)
    end
  end
end

machine_pid = TakeANumber.start()

# a client sending a message to the machine
send(machine_pid, {:report_state, self()})
send(machine_pid, {:take_a_number, self()})
send(machine_pid, {:take_a_number, self()})
send(machine_pid, {:take_a_number, self()})
send(machine_pid, :stop)
send(machine_pid, {:take_a_number, self()})
