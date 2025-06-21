require "test_helper"

class WebsitesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get websites_index_url
    assert_response :success
  end

  test "should get new" do
    get websites_new_url
    assert_response :success
  end

  test "should get create" do
    get websites_create_url
    assert_response :success
  end

  test "should get edit" do
    get websites_edit_url
    assert_response :success
  end

  test "should get update" do
    get websites_update_url
    assert_response :success
  end

  test "should get destroy" do
    get websites_destroy_url
    assert_response :success
  end
end
