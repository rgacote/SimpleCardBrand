defmodule SimpleCardBrandHumo do
  @moduledoc """
  Humo tests.
  """
  use ExUnit.Case

  test "HumoWikipedia" do
    assert SimpleCardBrand.card_brand("9860", 16) == {:ok, :humo}
  end
end
