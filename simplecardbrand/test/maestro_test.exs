defmodule SimpleCardBrandMaestro do
  @moduledoc """
  Maestro tests.

  6759 conflicts with Maestro UK.
  Assigned to Maestro UK.

  """
  use ExUnit.Case

  test "MaestroWikipedia" do
    for pan <- ["5018", "5020", "5038", "5893", "6304", "6761", "6762", "6763"] do
      for pan_length <- 12..19 do
        assert SimpleCardBrand.card_brand(pan, pan_length) == {:ok, :maestro}
      end
    end
  end
end
