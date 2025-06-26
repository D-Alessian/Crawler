require "test_helper"

class ServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get run_notifier" do
    get services_run_notifier_url
    assert_response :success
  end

  test "should get run_comparison" do
    get services_run_comparison_url
    assert_response :success
  end
end
