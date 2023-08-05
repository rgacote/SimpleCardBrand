defmodule SimpleCardBrandDinersClubInternational do
  @moduledoc """
  Diners Club International specific tasks.
  """
  use ExUnit.Case

  test "DinersClubInternationalWikipedia" do
    for n <- 14..19 do
      assert SimpleCardBrand.card_brand("36", n) == {:ok, :dinersclubinternational}
    end
  end
end
