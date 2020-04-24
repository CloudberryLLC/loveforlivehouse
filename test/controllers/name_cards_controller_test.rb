require 'test_helper'

class NameCardsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get name_cards_new_url
    assert_response :success
  end

  test "should get create" do
    get name_cards_create_url
    assert_response :success
  end

  test "should get edit" do
    get name_cards_edit_url
    assert_response :success
  end

  test "should get update" do
    get name_cards_update_url
    assert_response :success
  end

  test "should get show" do
    get name_cards_show_url
    assert_response :success
  end

  test "should get index" do
    get name_cards_index_url
    assert_response :success
  end

  test "should get destroy" do
    get name_cards_destroy_url
    assert_response :success
  end

end
