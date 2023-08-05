defmodule SimpleCardBrandInstaPayment do
  @moduledoc """
  InstaPayment tests.
  """
  use ExUnit.Case

  test "InstaPaymentWikipedia" do
    for pan <- 637..639 do
      assert SimpleCardBrand.card_brand(Integer.to_string(pan), 16) == {:ok, :instapayment}
    end
  end
end
