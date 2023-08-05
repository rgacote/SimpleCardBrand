defmodule SimpleCardBrandUATP do
  @moduledoc """
  UATP tests.
  """
  use ExUnit.Case

  test "UatpWikipedia" do
    assert SimpleCardBrand.card_brand("1", 15) == {:ok, :uatp}
  end
end
