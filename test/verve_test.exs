defmodule SimpleCardBrandVerveTest do
  @moduledoc """
  Verve tests.
  """
  use ExUnit.Case

  test "VerveWikipedia" do
    for pan <- [
          "506099",
          "506100",
          "506197",
          "506198",
          "507865",
          "507866",
          "507963",
          "507964",
          "650002",
          "650003",
          "650026",
          "650027"
        ] do
      for pan_length <- [16, 18, 19] do
        assert SimpleCardBrand.card_brand(pan, pan_length) == {:ok, :verve}
      end
    end
  end
end
