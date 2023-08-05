defmodule SimpleCardBrandUzCard do
  @moduledoc """
  UzCard tests.
  """
  use ExUnit.Case

  test "UzCardWikipedia" do
    assert SimpleCardBrand.card_brand("8600", 16) == {:ok, :uzcard}
  end
end
