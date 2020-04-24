require 'test_helper'

class TokushouhousControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get tokushouhous_show_url
    assert_response :success
  end

end
