defmodule PropertyBasedTestingTest do
  use ExUnit.Case
  use PropCheck

  doctest PropertyBasedTesting

  property "always works" do
    forall type <- term() do
      boolean(type)
    end
  end

  def boolean(_) do
    true
  end
end
