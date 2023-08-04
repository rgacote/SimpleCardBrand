defmodule SimpleCardBrandAmericanExpressTest do
  @moduledoc """
  American Express specific tasks.

  """
  use ExUnit.Case

  test "AmericanExpress" do
    assert SimpleCardBrand.card_brand("345678901234567") == {:ok, :americanexpress}
    assert SimpleCardBrand.card_brand("3457", 15) == {:ok, :americanexpress}
  end
end
