defmodule JsonParserTest do
  use ExUnit.Case
  doctest JsonParser

  test "the truth" do
    assert 1 + 1 == 2
  end


  test "" do
    json_strings = ~s({"key": "value"})

    assert json_strings |> JsonParser.decode == json_strings |> Poison.decode!
  end
end
