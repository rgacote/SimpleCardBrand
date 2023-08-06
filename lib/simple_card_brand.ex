defmodule SimpleCardBrand.Guards do
  @moduledoc """
  Guard macros.
  """
  @moduledoc since: "0.1.0"

  @doc """
  Check the PAN length is in the minimum to maximum allowed length (inclusive).
  Use in guards where `pan_length` is known to be an integer.

  ## Examples

      iex> SimpleCardBrand.Guards.pan_range(16, 12, 19)
      true

      iex> SimpleCardBrand.Guards.pan_range(16, 19, 19)
      false

  """
  defguard pan_range(pan_length, minimum, maximum) when pan_length in minimum..maximum

  @doc """
  Compare the first eight (8) digits of the `pan` against the UkrCard range.
  Use in guards where `pan` is known to be bytes.

  ## Examples

      iex> SimpleCardBrand.Guards.is_ukrcard("60420099123212")
      true

      iex> SimpleCardBrand.Guards.is_ukrcard("6042010022222")
      false
  """
  defguard is_ukrcard(pan)
           when binary_part(pan, 0, 8) >= "60400100" and binary_part(pan, 0, 8) <= "60420099"

  @spec is_verve(any) ::
          {:__block__ | {:., [], [:erlang | :orelse, ...]}, [],
           [{:= | {any, any, any}, [], [...]}, ...]}

  @doc """
  Compare the first six (6) digits of the `pan` against the Verve brand range.
  Use in guards where `pan` is known to be bytes.

  ## Examples

      iex> SimpleCardBrand.Guards.is_verve("506099212121")
      true

      iex> SimpleCardBrand.Guards.is_verve("50609123")
      false
  """
  defguard is_verve(pan)
           when (binary_part(pan, 0, 6) >= "506099" and binary_part(pan, 0, 6) <= "506198") or
                  (binary_part(pan, 0, 6) >= "507865" and binary_part(pan, 0, 6) <= "507964") or
                  (binary_part(pan, 0, 6) >= "650002" and binary_part(pan, 0, 6) <= "650027")
end

defmodule SimpleCardBrand do
  @moduledoc """
  Identify card brand from PAN or first six (6) digits of the PAN.
  The PAN (or first six thereof) must contain only digits without leading or trailing spaces.

  Supports:
  - American Express (:americanexpress)
  - BORICA (:borica)
  - China T-Union (:chinatunion)
  - China UnionPay (:chinaunionpay)
  - Dankort (:dankort)
  - Diners Club (:dinersclub)
  - Diners Club International (:dinersclubinternational)
  - Discover (:discover)
  - GPN (:gpn)
  - Humo (:humo)
  - InstaPayment (:instapayment)
  - InterPayment (:interpayment)
  - JCB: (:jcb)
  - LankaPay: (:lankapay)
  - Maestro (:maestro)
  - Maestro UK (:maestrouk)
  - Mastercard (:mastercard)
  - Mir (:mir)
  - Napas (:napas)
  - RuPay (:rupay)
  - Troy (:troy)
  - UATP (:uatp)
  - UkrCard (:ukrcard)
  - UzCard (:uzcard)
  - Verve (:verve)
  - Visa (:visa)
  - Visa Electron (:visaelectron)

  Rules as per: https://en.wikipedia.org/wiki/Payment_card_number

  """

  import SimpleCardBrand.Guards

  @doc ~S"""
  Identify the card brand from the PAN (Payment card Account Number).

  Check for UkrCard and Verve early.

  ## Examples

      iex> SimpleCardBrand.card_brand("4111111111111111")
      {:ok, :visa}

      iex> SimpleCardBrand.card_brand("506099", 19)
      {:ok, :verve}

      iex> SimpleCardBrand.card_brand("60400100", 19)
      {:ok, :ukrcard}


  """
  def card_brand(pan) when is_binary(pan) do
    pan_head =
      String.slice(pan, 0, 6)
      |> String.codepoints()

    _card_brand(pan_head, String.length(pan))
  end

  @spec card_brand(binary, integer) :: {:error} | {:ok, atom}
  @doc ~S"""
  Check for Verve early.

  TBD: Example and reasoning.

  """
  def card_brand(pan, pan_length)
      when is_binary(pan) and is_integer(pan_length) and pan_length in [16, 18, 19] and
             is_verve(pan) do
    {:ok, :verve}
  end

  def card_brand(pan, pan_length)
      when is_binary(pan) and is_integer(pan_length) and pan_length in [16, 18, 19] and
             is_ukrcard(pan) do
    {:ok, :ukrcard}
  end

  def card_brand(pan, pan_length) when is_binary(pan) and is_integer(pan_length) do
    _card_brand(String.codepoints(pan), pan_length)
  end

  # China T-Union
  defp _card_brand(["3", "1" | _], 19) do
    {:ok, :chinatunion}
  end

  # American Express
  defp _card_brand(["3", second | _], 15) when second in ["4", "7"] do
    {:ok, :americanexpress}
  end

  # LankaPay
  defp _card_brand(["3", "5", "7", "1", "1", "1" | _], 16) do
    {:ok, :lankapay}
  end

  # JCB
  defp _card_brand(["3", "5" | pan], pan_length) when pan_range(pan_length, 16, 19) do
    sub_pan =
      Enum.slice(pan, 0, 2)
      |> Enum.join()

    if "28" <= sub_pan and sub_pan <= "89" do
      {:ok, :jcb}
    else
      {:error}
    end
  end

  # Diners Club International
  defp _card_brand(["3", "6" | _], pan_length) when pan_range(pan_length, 14, 19) do
    {:ok, :dinersclubinternational}
  end

  # Diners Club International
  # 54 is in the Mastercard range. Branded as Diners in US and Canada
  defp _card_brand(["5", "4" | _], 16) do
    {:ok, :dinersclub}
  end

  # BORICA
  defp _card_brand(["2", "2", "0", "5" | _], 16) do
    {:ok, :borica}
  end

  # Mir
  defp _card_brand(["2", "2", "0", fourth | _], pan_length)
       when fourth in ["0", "1", "2", "3", "4"] and pan_range(pan_length, 16, 19) do
    {:ok, :mir}
  end

  # Mastercard and GPN starting with 2
  defp _card_brand(["2" | pan], 16) do
    sub_pan =
      Enum.slice(pan, 0, 3)
      |> Enum.join()

    if "221" <= sub_pan and sub_pan <= "720" do
      {:ok, :mastercard}
    else
      {:ok, :gpn}
    end
  end

  # Mastercard
  # 54 cards are branded as Diners in US and Canada.
  defp _card_brand(["5", second | _], 16) when second in ["1", "2", "3", "5"] do
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
  defp _card_brand(["4" | _], pan_length) when pan_length in [13, 16, 19] do
    {:ok, :visa}
  end

  # Discover
  defp _card_brand(["6", "0", "1", "1" | _], pan_length) when pan_range(pan_length, 16, 19) do
    {:ok, :discover}
  end

  # Discover
  defp _card_brand(["6", "4", third | _], pan_length)
       when third in ["4", "5", "6", "7", "8", "9"] and pan_range(pan_length, 16, 19) do
    {:ok, :discover}
  end

  # Discover
  defp _card_brand(["6", "2", "2" | tail], pan_length) when pan_range(pan_length, 16, 19) do
    sub_pan =
      Enum.slice(tail, 0, 3)
      |> Enum.join()

    if "126" <= sub_pan and sub_pan <= "925" do
      {:ok, :discover}
    else
      {:error}
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

  # Maestro UK
  # Conflicts with Maestro range.
  defp _card_brand(["6", "7", "5", "9" | _], pan_length) when pan_range(pan_length, 12, 19) do
    {:ok, :maestrouk}
  end

  # Maestro UK
  defp _card_brand(["6", "7", "6", "7", "7", sixth | _], pan_length)
       when sixth in ["0", "4"] and pan_range(pan_length, 12, 19) do
    {:ok, :maestrouk}
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
  defp _card_brand(["6", "7", "6", fourth | _], pan_length)
       when fourth in ["1", "2", "3"] and pan_range(pan_length, 12, 19) do
    {:ok, :maestro}
  end

  # UATP
  defp _card_brand(["1" | _], 15) do
    {:ok, :uatp}
  end

  # Dankort
  defp _card_brand(["5", "0", "1", "9" | _], 16) do
    {:ok, :dankort}
  end

  # RuPay
  defp _card_brand(["6", "0" | _], 16) do
    {:ok, :rupay}
  end

  # RuPay
  defp _card_brand(["6", "5" | _], 16) do
    {:ok, :rupay}
  end

  # RuPay
  defp _card_brand(["8", "1" | _], 16) do
    {:ok, :rupay}
  end

  # RuPay
  defp _card_brand(["8", "2" | _], 16) do
    {:ok, :rupay}
  end

  # RuPay
  defp _card_brand(["5", "0", "8" | _], 16) do
    {:ok, :rupay}
  end

  # RuPay
  defp _card_brand(["3", "5", "3" | _], 16) do
    {:ok, :rupay}
  end

  # RuPay
  defp _card_brand(["3", "5", "6" | _], 16) do
    {:ok, :rupay}
  end

  # InstaPayment
  defp _card_brand(["6", "3", third | _], pan_length)
       when third in ["7", "8", "9"] and pan_range(pan_length, 16, 19) do
    {:ok, :instapayment}
  end

  # InterPayment
  defp _card_brand(["6", "3", "6" | _], pan_length) when pan_range(pan_length, 16, 19) do
    {:ok, :interpayment}
  end

  # UzCard
  defp _card_brand(["8", "6", "0", "0" | _], 16) do
    {:ok, :uzcard}
  end

  # Napas
  defp _card_brand(["9", "7", "0", "4" | _], 16) do
    {:ok, :napas}
  end

  # Napas
  defp _card_brand(["9", "7", "9", "2" | _], 16) do
    {:ok, :troy}
  end

  # Humo
  defp _card_brand(["9", "8", "6", "0" | _], 16) do
    {:ok, :humo}
  end

  # GPN starting with 2 handled by Mastercard pattern match.
  defp _card_brand([first | _], 16) when first in ["1", "6", "7", "8", "9"] do
    {:ok, :gpn}
  end

  # Error
  defp _card_brand(_, _) do
    {:error}
  end
end
