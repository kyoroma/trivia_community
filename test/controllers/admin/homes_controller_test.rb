require "test_helper"

class Admin::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_homes_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_homes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_homes_destroy_url
    assert_response :success
  end

  test "should get top" do
    get admin_homes_top_url
    assert_response :success
  end
end
