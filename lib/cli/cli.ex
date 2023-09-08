defmodule Commandline.CLI do
  @moduledoc """
  Command line interface for checking payment card account number brands.

  Build using mix escript.build from project root.

  ## Examples

      iex> ./simplecardbrand 41111111111111111
      PAN: 41111111111111111 -> Unknown card brand.

      iex> ./simplecardbrand 4111111111111111 7111111111111111 8331111111111111111
      PAN: 4111111111111111 -> Unknown card brand.
      PAN: 7111111111111111 -> Brand: gpn
      PAN: 8331111111111111111 -> Unknown card brand.

      iex> ./simplecardbrand 4111111 --pan-length=16
      PAN: 4111111 -> Brand: visa
  """

  # https://inquisitivedeveloper.com/learn-with-me-elixir-elixirlargesort-intgen-project-part-2-77/
  # https://clairettran.medium.com/elixir-beginner-ii-tutorial-ab219ba6f4cd
  @doc """
  Entry point.

  See module documentation for usage.
  """
  def main(args) do
    {opts, argv, _errors} =
      OptionParser.parse(args,
        switches: [pan_length: :integer],
        aliases: []
      )

    opts
    |> Enum.into(%{})
    |> _brandit(argv)
  end

  defp _brandit(%{pan_length: pan_length} = flags, [pan | pans]) do
    case SimpleCardBrand.card_brand(pan, pan_length) do
      {:ok, brand} -> IO.puts("PAN: #{pan} -> Brand: #{brand}")
      {:error, {_, reason}} -> IO.puts("PAN: #{pan} -> #{reason}")
    end

    _brandit(flags, pans)
  end

  defp _brandit(%{}, [pan | pans]) do
    case SimpleCardBrand.card_brand(pan) do
      {:ok, brand} -> IO.puts("PAN: #{pan} -> Brand: #{brand}")
      {:error, {_, reason}} -> IO.puts("PAN: #{pan} -> #{reason}")
    end

    _brandit(%{}, pans)
  end

  defp _brandit(%{}, []) do
  end
end
