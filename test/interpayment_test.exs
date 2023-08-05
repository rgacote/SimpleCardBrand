defmodule SimpleCardBrandInterPayment do
  @moduledoc """
  InterPayment tests.
  """
  use ExUnit.Case

  test "InterPaymentWikipedia" do
    for n <- 16..19 do
      assert SimpleCardBrand.card_brand("636", n) == {:ok, :interpayment}
    end
  end
end
