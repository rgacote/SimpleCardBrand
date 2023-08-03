defmodule SimpleCardBrand.Guards do
  @moduledoc """
  Guard macros.
  """

  @doc """
  True if the PAN length is in the minimum to maximum allowed length (inclusive).

  Returns true

  """
  defguard pan_range(minimum, maximum, pan_length) when pan_length in minimum..maximum

end


defmodule SimpleCardBrand do
  @moduledoc """
  Identify card brand from PAN or first six (6) digits of the PAN.

  Supports:
  - American Express (:americanexpress)
  - Discover (:discover)
  - Mastercard (:mastercard)
  - Visa (:visa)

  Rules as per: https://en.wikipedia.org/wiki/Payment_card_number

  """

  import SimpleCardBrand.Guards

  @doc """
  Identify the card brand from the PAN (Payment card Account Number).
  """
  def card_brand(pan) do
    pan_head = String.slice(pan, 0, 6)
      |> String.codepoints()
    _card_brand(pan_head, String.length(pan))
  end

  @doc """
  Identify the card brand from the first six (6) digits of the PAN and the length.
  """
  def card_brand(pan_head, pan_length) do
    _card_brand(String.codepoints(pan_head), pan_length)
  end

  @doc """American Express"""
  defp _card_brand([ "3", second | _ ], 15) when second in ["4", "7"] do
    {:ok, :americanexpress}
  end

  @doc """Mastercard"""
  defp _card_brand([ "2" | pan ], 16) do
    sub_pan = Enum.slice(pan, 0, 3)
      |> Enum.join()

    cond do
      "221" <= sub_pan and sub_pan <= "720"-> {:ok, :mastercard}
      true -> {:error}
    end

  end

  @doc """Mastercard"""
  defp _card_brand([ "5", second | _ ], 16) when second in ["1", "2", "3", "4", "5"] do
    {:ok, :mastercard}
  end

  @doc """Visa"""
  defp _card_brand([ "4" | _ ], pan_length) when pan_length in [13, 16, 19] do
    {:ok, :visa}
  end

  @doc """Discover"""
  defp  _card_brand(["6", "0", "1", "1" | _], pan_length) when pan_range(16, 19, pan_length) do
    {:ok, :discover}
  end

  @doc """Discover"""
  defp _card_brand(["6", "4", third | _], pan_length) when third in ["4", "5", "6", "7", "8", "9"] and pan_range(16, 19, pan_length) do
    {:ok, :discover}
  end

  @doc """Discover"""
  defp _card_brand(["6", "2", "2" | tail], pan_length) when pan_range(16, 19, pan_length) do
    sub_pan = Enum.slice(tail, 0, 3)
      |> Enum.join()

    cond do
      "126" <= sub_pan and sub_pan <= "925"-> {:ok, :discover}
      true -> {:error}
    end
  end

  @doc """Discover"""
  defp _card_brand(["6", "5" | _], pan_length) when pan_range(16, 19, pan_length) do
    {:ok, :discover}
  end

  @doc """Unknown brand"""
  defp _card_brand(_, _) do
    {:error}
  end
end

SimpleCardBrand.card_brand("2221000", 16)  # Mastercard
SimpleCardBrand.card_brand("2220000", 16)  # ErlangError
SimpleCardBrand.card_brand("4111111111111111", 16)  # Visa
SimpleCardBrand.card_brand("3456", 15)  # American Express
SimpleCardBrand.card_brand("3567", 15)  # Error
SimpleCardBrand.card_brand("648123", 17) # Discover
SimpleCardBrand.card_brand("62201111", 17) # Error
SimpleCardBrand.card_brand("622126", 17) # Discover
SimpleCardBrand.card_brand("4111111111111111")  # Visa
