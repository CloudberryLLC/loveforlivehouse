require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get clip" do
    get favorites_clip_url
    assert_response :success
  end

  test "should get unclip" do
    get favorites_unclip_url
    assert_response :success
  end

end
