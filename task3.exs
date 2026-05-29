defmodule Task3 do
def all_same_digits(n) when n<=0, do: false
  def all_same_digits(n) do
    first = rem(n, 10)
    check(div(n, 10), first)
  end
 
  defp check(0, _first), do: true
  defp check(n, first) do
    if rem(n, 10) != first do
      false
    else
      check(div(n, 10), first)
    end
  end
end
 
IO.write("Enter N: ")
count = IO.read(:line) |> String.trim() |> String.to_integer()
 
IO.puts("Enter numbers:")
found =
  Enum.reduce(1..count, false, fn _, found ->
    x = IO.read(:line) |> String.trim() |> String.to_integer()
    if Task3.all_same_digits(x) do
      IO.write("#{x} ")
      true
    else
      found
    end
  end)
 
if !found, do: IO.puts("not found"), else: IO.puts("")
