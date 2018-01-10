require_relative "../application_system_test_case"

class ShoesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit "/"
    raise @response.inspect
  end
end
