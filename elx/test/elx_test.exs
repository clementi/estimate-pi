defmodule ElxTest do
  use ExUnit.Case
  doctest Elx

  test "greets the world" do
    assert Elx.hello() == :world
  end
end
