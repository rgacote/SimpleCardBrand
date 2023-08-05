defmodule SimpleCardBrandLankaPay do
  @moduledoc """
  LankaPay tests.
  """
  use ExUnit.Case

  test "LankaPayWikipedia" do
    assert SimpleCardBrand.card_brand("357111", 16) == {:ok, :lankapay}
  end
end
