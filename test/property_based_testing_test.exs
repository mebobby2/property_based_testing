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


end
