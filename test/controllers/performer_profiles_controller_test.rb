require 'test_helper'

class PerformerProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get performer_profiles_index_url
    assert_response :success
  end

  test "should get new" do
    get performer_profiles_new_url
    assert_response :success
  end

  test "should get create" do
    get performer_profiles_create_url
    assert_response :success
  end

  test "should get show" do
    get performer_profiles_show_url
    assert_response :success
  end

  test "should get edit" do
    get performer_profiles_edit_url
    assert_response :success
  end

  test "should get update" do
    get performer_profiles_update_url
    assert_response :success
  end

  test "should get destroy" do
    get performer_profiles_destroy_url
    assert_response :success
  end

end
