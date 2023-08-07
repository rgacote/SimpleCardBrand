defmodule SimpleCardBrandErrorsTest do
  @moduledoc """
  Tests that return errors.
  """

  use ExUnit.Case

  test "PAN unknown" do
    assert SimpleCardBrand.card_brand("000000000000") ==
             {:error, {:pan_unknown, "Unknown card brand."}}
  end

  test "PAN too long" do
    # General
    assert SimpleCardBrand.card_brand("41111111111111111111") ==
             {:error, {:pan_too_long, "Maximum PAN length is 19, found 20."}}

    # UkrCard
    assert SimpleCardBrand.card_brand("604001001212116181921") ==
             {:error, {:pan_too_long, "Maximum PAN length is 19, found 21."}}

    # Verve
    assert SimpleCardBrand.card_brand("506099444444617181921") ==
             {:error, {:pan_too_long, "Maximum PAN length is 19, found 21."}}
  end

  test "PAN too short" do
    # General
    assert SimpleCardBrand.card_brand("41111111111") ==
             {:error, {:pan_too_short, "Minimum PAN length is 12, found 11."}}

    # UkrCard
    assert SimpleCardBrand.card_brand("60113232311") ==
             {:error, {:pan_too_short, "Minimum PAN length is 12, found 11."}}

    # Verve
    assert SimpleCardBrand.card_brand("48445678911") ==
             {:error, {:pan_too_short, "Minimum PAN length is 12, found 11."}}
  end
end
