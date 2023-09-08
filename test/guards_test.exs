defmodule SimpleCardBrandGuardsTest do
  @moduledoc """
  Test the guards.
  """

  use ExUnit.Case
  require SimpleCardBrand.Guards

  test "Valid PAN range." do
    assert SimpleCardBrand.Guards.pan_range(16, 12, 19)
  end

  test "Invalid PAN range." do
    assert not SimpleCardBrand.Guards.pan_range(16, 19, 19)
  end

  test "Valid UkrCard." do
    assert SimpleCardBrand.Guards.is_ukrcard("60420099123212")
  end

  test "Invalid UkrCard." do
    assert not SimpleCardBrand.Guards.is_ukrcard("6042010022222")
  end

  test "Valid Verve." do
    assert SimpleCardBrand.Guards.is_verve("506099212121")
  end

  test "Invalid Verve." do
    assert not SimpleCardBrand.Guards.is_verve("50609123")
  end
end
