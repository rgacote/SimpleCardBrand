defmodule SimpleCardBrandErrorsTest do
  @moduledoc """
  Tests that return errors.
  """

  use ExUnit.Case

  test "ErrorsTooLong" do
    # General
    assert SimpleCardBrand.card_brand("41111111111111111111") ==
             {:error, "Maximum PAN length 19, found 20."}

    # UkrCard
    assert SimpleCardBrand.card_brand("604001001212116181921") ==
             {:error, "Maximum PAN length 19, found 21."}

    # Verve
    assert SimpleCardBrand.card_brand("506099444444617181921") ==
             {:error, "Maximum PAN length 19, found 21."}
  end

  test "ErrorsTooShort" do
    # General
    assert SimpleCardBrand.card_brand("41111111111") ==
             {:error, "Minimum PAN length is 12, found 11."}

    # UkrCard
    assert SimpleCardBrand.card_brand("60113232311") ==
             {:error, "Minimum PAN length is 12, found 11."}

    # Verve
    assert SimpleCardBrand.card_brand("48445678911") ==
             {:error, "Minimum PAN length is 12, found 11."}
  end
end