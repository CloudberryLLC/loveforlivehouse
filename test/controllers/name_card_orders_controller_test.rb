require 'test_helper'

class NameCardOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get name_card_orders_index_url
    assert_response :success
  end

  test "should get new" do
    get name_card_orders_new_url
    assert_response :success
  end

  test "should get create" do
    get name_card_orders_create_url
    assert_response :success
  end

  test "should get show" do
    get name_card_orders_show_url
    assert_response :success
  end

  test "should get edit" do
    get name_card_orders_edit_url
    assert_response :success
  end

  test "should get update" do
    get name_card_orders_update_url
    assert_response :success
  end

  test "should get destroy" do
    get name_card_orders_destroy_url
    assert_response :success
  end

end
