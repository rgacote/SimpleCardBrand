defmodule SimpleCardBrandMir do
  @moduledoc """
  Mir tests.
  """
  use ExUnit.Case

  test "MirWikipedia" do
    for pan <- 2200..2204 do
      for pan_length <- 16..19 do
        assert SimpleCardBrand.card_brand(Integer.to_string(pan), pan_length) == {:ok, :mir}
      end
    end
  end
end
