defmodule SimpleCardBrand.Guards do
  @moduledoc """
  Guard macros.
  """

  @doc """
  True if the PAN length is in the minimum to maximum allowed length (inclusive).

  Returns true

  """
  defguard pan_range(pan_length, minimum, maximum) when pan_length in minimum..maximum

end


defmodule SimpleCardBrand do
  @moduledoc """
  Identify card brand from PAN or first six (6) digits of the PAN.
  The PAN (or first six thereof) must contain only digits without leading or trailing spaces.

  Supports:
  - American Express (:americanexpress)
  - China T-Union (:chinatunion)
  - China UnionPay (:chinaunionpay)
  - Diners Club (:dinersclub)
  - Diners Club International (:dinersclubinternational)
  - Discover (:discover)
  - JCB: (:jcb)
  - Maestro (:maestro)
  - Maestro UK (:maestrouk)
  - Mastercard (:mastercard)
  - Visa (:visa)
  - Visa Electron (:visaelectron)

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

  # China T-Union
  defp _card_brand(["3", "1" | _], 19)  do
    {:ok, :chinatunion}
  end

  # American Express
  defp _card_brand([ "3", second | _ ], 15) when second in ["4", "7"] do
    {:ok, :americanexpress}
  end

  # JCB
  defp _card_brand(["3", "5"  | pan], pan_length) when pan_length in [13, 16, 19] do
    sub_pan = Enum.slice(pan, 0, 2)
      |> Enum.join()

    cond do
      "28" <= sub_pan and sub_pan <= "89"-> {:ok, :jcb}
      true -> {:error}
    end
  end

  # Diners Club International
  defp _card_brand([ "3", "6" | _ ], pan_length) when pan_range(pan_length, 14, 19) do
    {:ok, :dinersclubinternational}
  end

  # Diners Club International
  # 54 is in the Mastercard range. Branded as Diners in US and Canada
  defp _card_brand([ "5", "4" | _ ], 16) do
    {:ok, :dinersclub}
  end

  # Mastercard
  defp _card_brand([ "2" | pan ], 16) do
    sub_pan = Enum.slice(pan, 0, 3)
      |> Enum.join()

    cond do
      "221" <= sub_pan and sub_pan <= "720"-> {:ok, :mastercard}
      true -> {:error}
    end

  end

  # Mastercard
  # 54 cards are branded as Diners in US and Canada.
  defp _card_brand([ "5", second | _ ], 16) when second in ["1", "2", "3", "5"] do
    {:ok, :mastercard}
  end

  # Visa Electron
  defp _card_brand(["4", "0", "2", "6" | _], 16) do
    {:ok, :visaelectron}
  end

  # Visa Electron
  defp _card_brand(["4", "1", "7", "5", "0", "0" | _], 16) do
    {:ok, :visaelectron}
  end

  # Visa Electron
  defp _card_brand(["4", "5", "0", "8" | _], 16) do
    {:ok, :visaelectron}
  end

  # Visa Electron
  defp _card_brand(["4", "8", "4", "4" | _], 16) do
    {:ok, :visaelectron}
  end

  # Visa Electron
  defp _card_brand(["4", "9", "1", fourth | _], 16) when fourth in ["3", "7"] do
    {:ok, :visaelectron}
  end

  # Visa
  defp _card_brand([ "4" | _ ], pan_length) when pan_length in [13, 16, 19] do
    {:ok, :visa}
  end

  # Discover
  defp  _card_brand(["6", "0", "1", "1" | _], pan_length) when pan_range(pan_length, 16, 19) do
    {:ok, :discover}
  end

  # Discover
  defp _card_brand(["6", "4", third | _], pan_length) when third in ["4", "5", "6", "7", "8", "9"] and pan_range(pan_length, 16, 19) do
    {:ok, :discover}
  end

  # Discover
  defp _card_brand(["6", "2", "2" | tail], pan_length) when pan_range(pan_length, 16, 19) do
    sub_pan = Enum.slice(tail, 0, 3)
      |> Enum.join()

    cond do
      "126" <= sub_pan and sub_pan <= "925"-> {:ok, :discover}
      true -> {:error}
    end
  end

  # Discover
  defp _card_brand(["6", "5" | _], pan_length) when pan_range(pan_length, 16, 19) do
    {:ok, :discover}
  end

  # China UnionPay: After Discover 622
  defp _card_brand(["6", "2" | _], pan_length) when pan_range(pan_length, 16, 19) do
    {:ok, :chinaunionpay}
  end

  # Maestro
  defp _card_brand(["5", "0", "1", "8" | _], pan_length) when pan_range(pan_length, 12, 19) do
    {:ok, :maestro}
  end

  # Maestro
  defp _card_brand(["5", "0", "2", "0" | _], pan_length) when pan_range(pan_length, 12, 19) do
    {:ok, :maestro}
  end

  # Maestro
  defp _card_brand(["5", "0", "3", "8" | _], pan_length) when pan_range(pan_length, 12, 19) do
    {:ok, :maestro}
  end

  # Maestro
  defp _card_brand(["5", "8", "9", "3" | _], pan_length) when pan_range(pan_length, 12, 19) do
    {:ok, :maestro}
  end

  # Maestro
  defp _card_brand(["6", "3", "0", "4" | _], pan_length) when pan_range(pan_length, 12, 19) do
    {:ok, :maestro}
  end

  # Maestro
  defp _card_brand(["6", "7", "5", "9" | _], pan_length) when pan_range(pan_length, 12, 19) do
    {:ok, :maestro}
  end

  # Maestro
  defp _card_brand(["6", "7", "6", fourth | _], pan_length) when fourth in ["1", "2", "3"] and pan_range(pan_length, 12, 19) do
    {:ok, :maestro}
  end

  # Maestro UK
  defp _card_brand(["6", "7", "5", "9" | _], pan_length) when pan_range(pan_length, 12, 19) do
    {:ok, :maestrouk}
  end

  # Maestro UK
  defp _card_brand(["6", "7", "6", "7", "7", sixth | _], pan_length) when sixth in ["0", "4"] and pan_range(pan_length, 12, 19) do
    {:ok, :maestrouk}
  end

  # Error
  defp _card_brand(_, _) do
    {:error}
  end
end

SimpleCardBrand.card_brand("2221000", 16)  # Mastercard
SimpleCardBrand.card_brand("2220000", 16)  # Error
SimpleCardBrand.card_brand("4111111111111111", 16)  # Visa
SimpleCardBrand.card_brand("3456", 15)  # American Express
SimpleCardBrand.card_brand("3567", 15)  # Error
SimpleCardBrand.card_brand("648123", 17) # Discover
SimpleCardBrand.card_brand("62201111", 17) # Error
SimpleCardBrand.card_brand("622126", 17) # Discover
SimpleCardBrand.card_brand("4111111111111111")  # Visa
SimpleCardBrand.card_brand("622345", 17)  # China UnionPay
SimpleCardBrand.card_brand("31456", 19)  # China T-Union
SimpleCardBrand.card_brand("4175003", 16) # Visa Electron
SimpleCardBrand.card_brand("3527", 19) # Error
SimpleCardBrand.card_brand("3528345", 19) # JCB
SimpleCardBrand.card_brand("36312", 14) # Diners Club International
SimpleCardBrand.card_brand("545454", 16) # Diners Club International
SimpleCardBrand.card_brand("676771", 16) # Error
SimpleCardBrand.card_brand("67593", 12) # Maestro UK
SimpleCardBrand.card_brand("676770", 14) # Maestro UK
SimpleCardBrand.card_brand("67613", 12) # Maestro UK
