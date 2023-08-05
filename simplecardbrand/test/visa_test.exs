defmodule SimpleCardBrandVisa do
  @moduledoc """
  Visa tests.
  """
  use ExUnit.Case

  test "VisaWikipedia" do
    for pan_length <- [13, 16, 19] do
      assert SimpleCardBrand.card_brand("4", pan_length) == {:ok, :visa}
    end
  end
end
