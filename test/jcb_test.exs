defmodule SimpleCardBrandJCB do
  @moduledoc """
  JCB tests.
  """

  use ExUnit.Case
  use ExUnit.Parameterized

  # description
  test_with_params "JCBWikipedia",
                   # test case
                   fn pan, pan_length, expected ->
                     assert SimpleCardBrand.card_brand(pan, pan_length) == {:ok, expected}
                   end do
    [
      # parameters
      {"3528", 16, :jcb},
      {"3530", 17, :jcb},
      {"3540", 18, :jcb},
      {"3550", 19, :jcb},
      # {"3560", 16, :jcb},  # RuPay Co-brand
      {"3570", 17, :jcb},
      {"3580", 18, :jcb},
      {"3589", 19, :jcb}
    ]
  end
end
