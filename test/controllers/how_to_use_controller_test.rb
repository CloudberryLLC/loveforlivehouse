require 'test_helper'

class HowToUsesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get how_to_use_show_url
    assert_response :success
  end

end
