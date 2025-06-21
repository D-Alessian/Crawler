require "test_helper"

class CrawlConfigsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get crawl_configs_edit_url
    assert_response :success
  end

  test "should get update" do
    get crawl_configs_update_url
    assert_response :success
  end
end
