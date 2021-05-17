defmodule PropertyBasedTestingTest do
  use ExUnit.Case
  use PropCheck

  doctest PropertyBasedTesting

  # Technique 1: Modelling
  property "finds biggest element" do
    forall x <- non_empty(list(integer())) do
      PropertyBasedTesting.biggest(x) == model_biggest(x)
    end
  end

  def model_biggest(list) do
    List.last(Enum.sort(list))
  end

  # Technique 2: Generalizing example tests
  property "picks the last number" do
    forall {list, known_last} <- {list(number()), number()} do
      known_list = list ++ [known_last]
      known_last == List.last(known_list)
    end
  end

  # Technique 3: Invariants
  property "a sorted list has ordered pairs" do
    forall list <- list(term()) do
      is_ordered(Enum.sort(list))
    end
  end

  property "a sorted list keeps its size" do
    forall l <- list(number()) do
      length(l) == length(Enum.sort(l))
    end
  end

  property "no element added" do
    forall l <- list(number()) do
      sorted = Enum.sort(l)
      Enum.all?(sorted, fn element -> element in l end)
    end
  end

  property "no element deleted" do
    forall l <- list(number()) do
      sorted = Enum.sort(l)
      Enum.all?(l, fn element -> element in sorted end)
    end
  end

  def is_ordered([a, b | t]) do
    a <= b and is_ordered([b | t])
  end

  # lists with fewer than 2 elements
  def is_ordered(_) do
    true
  end

  # Technique 4: Symmetric Properties
  property "symmetric encoding/decoding" do
    forall data <- list({atom(), any()}) do
      encoded = encode(data)
      is_binary(encoded) and data == decode(encoded)
    end

  end
  def encode(t), do: :erlang.term_to_binary(t)
  def decode(t), do: :erlang.binary_to_term(t)

  # def strdatetime() do
  #   let(date_time <- datetime(), do: to_str(date_time))
  # end

  # def datetime() do
  #   {date(), time(), timezone()}
  # end

  # def month(), do: range(1, 12)
  # def day(), do: range(1, 31)
  # def time(), do: {range(0, 24), range(0, 59), range(0, 60)}

  # def timezone() do
  #   {elements([:+, :-]), shrink(range(0, 99), [range(0, 14), 0]),
  #    shrink(range(0, 99), [0, 15, 30, 45])}
  # end

  # def to_str({{y, m, d}, {h, mi, s}, {sign, ho, mo}}) do
  #   format_str = "~4..0b-~2..0b-~2..0bT~2..0b:~2..0b:~2..0b~s~2..0b:~2..0b"

  #   :io_lib.format(format_str, [y, m, d, h, mi, s, sign, ho, mo])
  #   |> to_string()
  # end

  # def tree_shrink(n) when n <= 1 do
  #   {:left, number()}
  # end

  # def tree_shrink(n) do
  #   per_branch = div(n, 2)

  #   let_shrink([
  #     left <- tree_shrink(per_branch),
  #     right <- tree_shrink(per_branch)
  #   ]) do
  #     {:branch, left, right}
  #   end
  # end
end
