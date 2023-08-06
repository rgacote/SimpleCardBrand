defmodule SimpleCardBrandRuPayTest do
  @moduledoc """
  RuPay tests.

  353 and 356 is co-branded with JCB
  65 is a Discover range
  """

  use ExUnit.Case, async: true
  use ExUnit.Parameterized

  test_with_params "RuPayWikipedia",
                   # test case
                   fn pan, pan_length, expected ->
                     assert SimpleCardBrand.card_brand(pan, pan_length) == {:ok, expected}
                   end do
    [
      {"60", 16, :rupay},
      {"81", 16, :rupay},
      {"82", 16, :rupay},
      {"508", 16, :rupay},
      {"353", 16, :rupay},
      {"356", 16, :rupay},
      {"65", 16, :discover}
    ]
  end
end
