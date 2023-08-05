defmodule SimpleCardBrandBORICA do
  @moduledoc """
  BORICA tests.
  """
  use ExUnit.Case

  test "BoricaWikipedia" do
    assert SimpleCardBrand.card_brand("2205", 16) == {:ok, :borica}
  end
end
