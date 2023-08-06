defmodule SimpleCardBrandUkrCardTest do
  @moduledoc """
  UkrCard tests.
  """
  use ExUnit.Case

  test "UkrCardWikipedia" do
    for pan <- [
          "60400100",
          "60400101",
          "60420098",
          "60420099"
        ] do
      for pan_length <- [16, 18, 19] do
        assert SimpleCardBrand.card_brand(pan, pan_length) == {:ok, :ukrcard}
      end
    end
  end
end
