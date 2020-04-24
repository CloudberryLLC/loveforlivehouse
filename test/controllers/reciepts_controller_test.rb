require 'test_helper'

class RecieptsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get reciepts_show_url
    assert_response :success
  end

end
