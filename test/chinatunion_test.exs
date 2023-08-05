defmodule SimpleCardBrandChinaTUnion do
  @moduledoc """
  China T-Union tests.
  """
  use ExUnit.Case

  test "ChinaTUnionWikipedia" do
    assert SimpleCardBrand.card_brand("31", 19) == {:ok, :chinatunion}
  end
end
