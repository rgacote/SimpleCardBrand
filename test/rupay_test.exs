defmodule SimpleCardBrandRuPayTest do
  @moduledoc """
  RuPay tests.

  353 and 356 is co-branded with JCB
  65 is a Discover range
  """
  use ExUnit.Case

  test "RuPayWikipedia" do
    for pan <- ["60", "81", "82", "508"] do
      assert SimpleCardBrand.card_brand(pan, 16) == {:ok, :rupay}
    end

    assert SimpleCardBrand.card_brand("353", 16) == {:ok, :jcb}
    assert SimpleCardBrand.card_brand("356", 16) == {:ok, :jcb}
    assert SimpleCardBrand.card_brand("65", 16) == {:ok, :discover}
  end
end
