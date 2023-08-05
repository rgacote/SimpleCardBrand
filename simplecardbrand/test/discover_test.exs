defmodule SimpleCardBrandDiscover do
  @moduledoc """
  Discover tests.
  """
  use ExUnit.Case

  test "DiscoverWikipediaStatic" do
    for pan <- ["6011", "65"] do
      for pan_length <- 16..19 do
        assert SimpleCardBrand.card_brand(pan, pan_length) == {:ok, :discover}
      end
    end
  end

  test "DiscoverWikipedia644" do
    for pan <- 644..649 do
      for pan_length <- 16..19 do
        assert SimpleCardBrand.card_brand(Integer.to_string(pan), pan_length) == {:ok, :discover}
      end
    end
  end

  test "DiscoverWikipedia622126" do
    for pan <- 622_126..622_925 do
      for pan_length <- 16..19 do
        assert SimpleCardBrand.card_brand(Integer.to_string(pan), pan_length) == {:ok, :discover}
      end
    end
  end
end
