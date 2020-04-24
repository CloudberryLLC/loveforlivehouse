require 'test_helper'

class HowToUsesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get how_to_uses_show_url
    assert_response :success
  end

end
