defmodule SimpleCardBrandDinersClub do
  @moduledoc """
  Diners Club tests.
  """
  use ExUnit.Case

  test "DinersClubWikipedia" do
    assert SimpleCardBrand.card_brand("54", 16) == {:ok, :dinersclub}
  end
end
