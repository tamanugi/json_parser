defmodule JsonParser do
  @moduledoc """
  Documentation for JsonParser.
  """

  @doc """
  Hello world.

  ## Examples

      iex> JsonParser.hello
      :world

  """
  def hello do
    :world
  end

  def decode(json) do
    case json do
      "{" <> rest ->
        decode(rest, :object, :key, %{})

      "\"" <> rest ->
        string_continue(rest, "")
    end
  end

  def decode("" , _, _, keys_and_values) do
    keys_and_values
  end

  def decode(<<char>> <> json, :object, state, keys_and_values) do
    case <<char>> do
      "\"" ->
        {string, rest} = string_continue(json, "")
        keys_and_values = Map.put(keys_and_values, state, string)

        decode(rest, :object, state, keys_and_values)
      ":" ->
        decode(json, :object, :value, keys_and_values)

      _ -> 
        decode(json, :object, state, keys_and_values)
    end
  end

  def string_continue(<<char>> <> rest, acc) do
    case <<char>> do
      "\"" -> {acc, rest}
      _ -> string_continue(rest, acc <> <<char>>)
    end
  end

end
