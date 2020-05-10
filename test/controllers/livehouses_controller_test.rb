require 'test_helper'

class LivehousesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get livehouses_index_url
    assert_response :success
  end

  test "should get new" do
    get livehouses_new_url
    assert_response :success
  end

  test "should get create" do
    get livehouses_create_url
    assert_response :success
  end

  test "should get show" do
    get livehouses_show_url
    assert_response :success
  end

  test "should get edit" do
    get livehouses_edit_url
    assert_response :success
  end

  test "should get update" do
    get livehouses_update_url
    assert_response :success
  end

  test "should get destroy" do
    get livehouses_destroy_url
    assert_response :success
  end

end
