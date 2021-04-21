defmodule WexServerTest do
  use ExUnit.Case
  doctest WexServer

  test "greets the world" do
    assert WexServer.hello() == :world
  end
end
