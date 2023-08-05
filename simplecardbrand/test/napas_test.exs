defmodule SimpleCardBrandNapas do
  @moduledoc """
  Napas tests.
  """
  use ExUnit.Case

  test "NapasWikipedia" do
    assert SimpleCardBrand.card_brand("9704", 16) == {:ok, :napas}
  end
end
