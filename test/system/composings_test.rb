require "application_system_test_case"

class ComposingsTest < ApplicationSystemTestCase
  setup do
    @composing = composings(:one)
  end

  test "visiting the index" do
    visit composings_url
    assert_selector "h1", text: "Composings"
  end

  test "creating a Composing" do
    visit composings_url
    click_on "New Composing"

    click_on "Create Composing"

    assert_text "Composing was successfully created"
    click_on "Back"
  end

  test "updating a Composing" do
    visit composings_url
    click_on "Edit", match: :first

    click_on "Update Composing"

    assert_text "Composing was successfully updated"
    click_on "Back"
  end

  test "destroying a Composing" do
    visit composings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Composing was successfully destroyed"
  end
end
