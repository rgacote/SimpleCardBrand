defmodule SimpleCardBrandTest do
  use ExUnit.Case
  doctest SimpleCardBrand

  # Copy scripts from single-file here.
  test "Placeholder" do
    assert SimpleCardBrand.card_brand("2221000", 16)  == {:ok, :mastercard }
    assert SimpleCardBrand.card_brand("2220000", 16)  == { :error }
    assert SimpleCardBrand.card_brand("4111111111111111", 16)  == {:ok, :visa }
    assert SimpleCardBrand.card_brand("3456", 15)  == {:ok, :americanexpress }
    assert SimpleCardBrand.card_brand("3567", 15)  == { :error }
    assert SimpleCardBrand.card_brand("648123", 17) == {:ok, :discover }
    assert SimpleCardBrand.card_brand("62201111", 17) == { :error }
    assert SimpleCardBrand.card_brand("623126", 17) == {:ok, :chinaunionpay }
    assert SimpleCardBrand.card_brand("4111111111111111")  == {:ok, :visa }
    assert SimpleCardBrand.card_brand("622345", 17)  == {:ok, :discover }
    assert SimpleCardBrand.card_brand("31456", 19)  == {:ok, :chinatunion }
    assert SimpleCardBrand.card_brand("4175003", 16) == {:ok, :visaelectron }
    assert SimpleCardBrand.card_brand("3527", 19) == { :error }
    assert SimpleCardBrand.card_brand("3528345", 19) == {:ok, :jcb }
    assert SimpleCardBrand.card_brand("36312", 14) == {:ok, :dinersclubinternational }
    assert SimpleCardBrand.card_brand("545454", 16) == {:ok, :dinersclub }
    assert SimpleCardBrand.card_brand("676771", 16) == { :error }
    assert SimpleCardBrand.card_brand("67593", 12) == {:ok, :maestro }
    assert SimpleCardBrand.card_brand("676770", 14) == {:ok, :maestrouk }
    assert SimpleCardBrand.card_brand("67613", 12) == {:ok, :maestro }
    assert SimpleCardBrand.card_brand("97041", 16) == {:ok, :napas }
    assert SimpleCardBrand.card_brand("98603", 16) == {:ok, :humo }
    assert SimpleCardBrand.card_brand("86001", 16) == {:ok, :uzcard }
    assert SimpleCardBrand.card_brand("111111111111111") == {:ok, :uatp }
    assert SimpleCardBrand.card_brand("2205", 16) == {:ok, :borica }
    assert SimpleCardBrand.card_brand("637", 16) == {:ok, :instapayment }
    assert SimpleCardBrand.card_brand("636", 18) == {:ok, :interpayment }
    assert SimpleCardBrand.card_brand("2201", 16) == {:ok, :mir }

  end
end
