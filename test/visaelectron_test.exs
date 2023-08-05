defmodule SimpleCardBrandVisaElectron do
  @moduledoc """
  Visa Electron tests.
  """
  use ExUnit.Case

  test "VisaElectronWikipedia" do
    for pan <- [4026, 417_500, 4508, 4844, 4913, 4917] do
      assert SimpleCardBrand.card_brand(Integer.to_string(pan), 16) == {:ok, :visaelectron}
    end
  end
end
