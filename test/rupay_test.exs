defmodule SimpleCardBrandRuPayTest do
  @moduledoc """
  RuPay tests.

  65 is a Discover range
  """

  use ExUnit.Case, async: true
  use ExUnitProperties

  property "RuPayWikipedia" do
    check all(fragment <- StreamData.member_of(Enum.take([60, 81, 82, 508, 353, 356], 6))) do
      assert SimpleCardBrand.card_brand(Integer.to_string(fragment), 16) == {:ok, :rupay}
    end
  end
end
