defmodule SimpleCardBrandChinaUnionPay do
  @moduledoc """
  China UnionPay specific tasks.
  """
  use ExUnit.Case

  test "ChinaUnionPayWikipedia" do
    for n <- 16..19 do
      assert SimpleCardBrand.card_brand("62", n) == {:ok, :chinaunionpay}
    end
  end
end
