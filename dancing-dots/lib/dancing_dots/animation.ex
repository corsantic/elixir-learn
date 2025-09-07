defmodule DancingDots.Animation do
  alias DancingDots.Animation

  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:ok, opts} | {:error, error}
  @callback handle_frame(dot, frame_number, opts) :: DancingDots.Dot.t()

  defmacro __using__(_) do
    quote do
      @behaviour Animation
      def init(opts), do: {:ok, opts}

      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  alias DancingDots.Animation
  use Animation

  @impl Animation
  def handle_frame(dot, frame_number, _) when rem(frame_number, 4) == 0,
    do: %{dot | opacity: dot.opacity / 2}

  @impl Animation
  def handle_frame(dot, _, _), do: dot
end

defmodule DancingDots.Zoom do
  alias DancingDots.Animation
  use Animation

  @impl Animation
  def init(velocity: velocity) when is_number(velocity), do: {:ok, [{:velocity, velocity}]}

  @impl Animation
  def init(opts),
    do:
      {:error,
       "The :velocity option is required, and its value must be a number. Got: #{inspect(opts[:velocity])}"}

  @impl Animation
  def handle_frame(dot, frame_number, velocity: velocity),
    do: %{dot | radius: dot.radius + (frame_number - 1) * velocity}
end
