require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Filling the form with a random word gets a message the word is not in the grid" do
    visit new_url
    fill_in "answer", with: "gfdgd"
    click_on "Play"
    assert_text "Sorry but GFDGD cannot be built out of GRID"
  end
end
