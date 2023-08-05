defmodule SimpleCardBrandJCB do
  @moduledoc """
  JCB tests.
  """
  use ExUnit.Case

  test "JCBWikipedia" do
    for pan <- 3528..3589 do
      for pan_length <- 16..19 do
        assert SimpleCardBrand.card_brand(Integer.to_string(pan), pan_length) == {:ok, :jcb}
      end
    end
  end
end
