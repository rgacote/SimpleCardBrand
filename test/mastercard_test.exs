defmodule SimpleCardBrandMastercard do
  @moduledoc """
  Mastercard tests.

  54 is branded as Diners Club in the US.
  """
  use ExUnit.Case

  test "MastercardWikipedia2221" do
    for pan <- 2221..2720 do
      assert SimpleCardBrand.card_brand(Integer.to_string(pan), 16) == {:ok, :mastercard}
    end
  end

  test "MastercardWikipedia51" do
    for pan <- ["51", "52", "53", "55"] do
      assert SimpleCardBrand.card_brand(pan, 16) == {:ok, :mastercard}
    end
  end
end
