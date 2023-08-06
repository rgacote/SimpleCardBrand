defmodule SimpleCardBrandJCB do
  @moduledoc """
  JCB tests.
  """

  use ExUnit.Case, async: true
  use ExUnitProperties

  property "JCBWikipedia" do
    check all(
            fragment <- StreamData.integer(3528..3589),
            pan_length <- StreamData.integer(16..19)
          ) do
      # Skip RuPay brand range.
      if fragment not in 3530..3539 and fragment not in 3560..3569 do
        assert SimpleCardBrand.card_brand(Integer.to_string(fragment), pan_length) ==
                 {:ok, :jcb}
      end
    end
  end
end
