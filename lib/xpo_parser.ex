defmodule XpoParser do
  @moduledoc """
  Documentation for XpoParser.
  """

  @doc """
  Hello world.

  ## Examples

      iex> XpoParser.hello()
      :world

  """
  def hello do
    :world
  end

  def get_object_list(filename) do
    regex = ~r/^\s*(?<object_type>\w+)\s+\#(?<object_name>[\w_0-9]+)$/i
    filename |> File.stream!([:read], :line)
    |> Stream.map(&(regex |> Regex.named_captures(&1)))
    |> Stream.map(fn nil -> nil; %{"object_type" => object_type, "object_name" => object_name} ->
      "Object type #{object_type}, Object name: #{object_name}"
    end)
    |> Stream.filter(fn nil -> false; _ -> true end)
    |> Enum.each(&IO.puts(&1))
    #
    # ~r/^\s*(?<object_type>\w+)\s+\#(?<object_name>[\w_0-9]+)$/miU
    #   |> Regex.named_captures(data)
    #   |> Enum.each(fn %{"object_type" => object_type, "object_name" => object_name} ->
    #     IO.puts "Object type #{object_type}, Object name: #{object_name}"
    #   end)
  end
end
