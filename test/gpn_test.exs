defmodule SimpleCardBrandGPN do
  @moduledoc """
  GPN tests.
  """
  use ExUnit.Case

  test "GpnWikipedia" do
    for first <- ["1", "2", "6", "7", "8", "9"] do
      assert SimpleCardBrand.card_brand(first, 16) == {:ok, :gpn}
    end
  end
end
