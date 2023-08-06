defmodule SimpleCardBrandTroy do
  @moduledoc """
  Troy tests.

  Identify 65 as Discover.

  """
  use ExUnit.Case

  test "TroyWikipedia" do
    assert SimpleCardBrand.card_brand("9792", 16) == {:ok, :troy}
    assert SimpleCardBrand.card_brand("65", 16) == {:ok, :discover}
  end
end
