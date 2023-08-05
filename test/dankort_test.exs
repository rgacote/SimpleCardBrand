defmodule SimpleCardBrandDankort do
  @moduledoc """
  Dankort tests.

  4571 is Visa co-brand.

  """
  use ExUnit.Case

  test "DankortWikipedia" do
    assert SimpleCardBrand.card_brand("5019", 16) == {:ok, :dankort}
    assert SimpleCardBrand.card_brand("4571", 16) == {:ok, :visa}
  end
end
