defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @error_message "stack underflow occurred"
    defexception message: @error_message

    @impl true
    def exception(term) do
      case term do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: @error_message <> ", context: " <> term}
      end
    end
  end

  def divide(numbers) when length(numbers) <= 1, do: raise(StackUnderflowError, "when dividing")
  def divide([0, _]), do: raise(DivisionByZeroError)
  def divide([a, b]), do: b / a
end
