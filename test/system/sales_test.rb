require "application_system_test_case"

class SalesTest < ApplicationSystemTestCase
  setup do
    @sale = sales(:one)
  end

  test "visiting the index" do
    visit sales_url
    assert_selector "h1", text: "Sales"
  end

  test "creating a Sale" do
    visit sales_url
    click_on "New Sale"

    fill_in "Item description", with: @sale.item_description
    fill_in "Item price", with: @sale.item_price
    fill_in "Merchant address", with: @sale.merchant_address
    fill_in "Merchant name", with: @sale.merchant_name
    fill_in "Purchase count", with: @sale.purchase_count
    fill_in "Purchaser name", with: @sale.purchaser_name
    click_on "Create Sale"

    assert_text "Sale was successfully created"
    click_on "Back"
  end

  test "updating a Sale" do
    visit sales_url
    click_on "Edit", match: :first

    fill_in "Item description", with: @sale.item_description
    fill_in "Item price", with: @sale.item_price
    fill_in "Merchant address", with: @sale.merchant_address
    fill_in "Merchant name", with: @sale.merchant_name
    fill_in "Purchase count", with: @sale.purchase_count
    fill_in "Purchaser name", with: @sale.purchaser_name
    click_on "Update Sale"

    assert_text "Sale was successfully updated"
    click_on "Back"
  end

  test "destroying a Sale" do
    visit sales_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sale was successfully destroyed"
  end
end
