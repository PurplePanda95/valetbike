require "test_helper"

class RentalsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get rental_show_url
    assert_response :success
  end

  test "should get new" do
    get rental_new_url
    assert_response :success
  end

  test "should get bike_return" do
    get rental_bike_return_url
    assert_response :success
  end

  test "should get index" do
    get rental_index_url
    assert_response :success
  end

  test "should get confirm" do
    get rental_confirm_url
    assert_response :success
  end
end
