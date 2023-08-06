defmodule SimpleCardBrandErrorsTest do
  @moduledoc """
  Tests that return errors.
  """
  use ExUnit.Case

  test "ErrorsTooLong" do
    # General
    assert SimpleCardBrand.card_brand("41111111111111111111") == {:error}

    # UkrCard
    assert SimpleCardBrand.card_brand("604001001212116181921") == {:error}

    # Verve
    assert SimpleCardBrand.card_brand("506099444444441617181921") == {:error}
  end

  test "ErrorsTooShort" do
    # General
    assert SimpleCardBrand.card_brand("41111111111111") == {:error}

    # UkrCard
    assert SimpleCardBrand.card_brand("60400100121215") == {:error}

    # Verve
    assert SimpleCardBrand.card_brand("50609944444415") == {:error}
  end

end
