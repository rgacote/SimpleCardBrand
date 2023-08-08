defmodule Commandline.CLI do
  @moduledoc """
  Command line interface for checking payment card account number brands.

  ## Examples

      iex> ./simplecardbrand 41111111111111111
      {:ok, :visa}

      iex> ./simplecardbrand 41111111111111111 7111111111111111 8331111111111111111
      {:ok, :visa}
      {:ok, :gpn}
      {:error, {:pan_unknown, "Unknown card brand."}}

  """

  @doc """
  """
  def main(args) do
    {_opts, argv, _errors} =
      OptionParser.parse(args,
        switches: [],
        aliases: []
      )

    for pan <- argv do
      case SimpleCardBrand.card_brand(pan) do
        {:ok, brand} -> IO.puts("PAN: #{pan} -> Brand: #{brand}")
        {:error, {_, reason}} -> IO.puts("PAN: #{pan} -> #{reason}")
      end
    end
  end
end
