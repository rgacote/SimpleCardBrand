defmodule SimpleCardBrandAmericanExpressTest do
  @moduledoc """
  American Express tests.
  """
  use ExUnit.Case

  test "AmericanExpressWikipedia" do
    assert SimpleCardBrand.card_brand("345678901234567") == {:ok, :americanexpress}
    assert SimpleCardBrand.card_brand("3457", 15) == {:ok, :americanexpress}
    assert SimpleCardBrand.card_brand("37", 15) == {:ok, :americanexpress}
  end
end
