defmodule SimpleCardBrandMaestroUK do
  @moduledoc """
  Maestro UK tests.
  """
  use ExUnit.Case

  test "MaestroUKWikipedia" do
    for pan <- ["6759", "676770", "676774"] do
      for pan_length <- 12..19 do
        assert SimpleCardBrand.card_brand(pan, pan_length) == {:ok, :maestrouk}
      end
    end
  end
end
