require "application_system_test_case"

class ComposersTest < ApplicationSystemTestCase
  setup do
    @composer = composers(:one)
  end

  test "visiting the index" do
    visit composers_url
    assert_selector "h1", text: "Composers"
  end

  test "creating a Composer" do
    visit composers_url
    click_on "New Composer"

    click_on "Create Composer"

    assert_text "Composer was successfully created"
    click_on "Back"
  end

  test "updating a Composer" do
    visit composers_url
    click_on "Edit", match: :first

    click_on "Update Composer"

    assert_text "Composer was successfully updated"
    click_on "Back"
  end

  test "destroying a Composer" do
    visit composers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Composer was successfully destroyed"
  end
end
