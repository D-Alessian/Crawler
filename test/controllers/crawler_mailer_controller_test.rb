require "test_helper"

class CrawlerMailerControllerTest < ActionDispatch::IntegrationTest
  test "should get daily_report" do
    get crawler_mailer_daily_report_url
    assert_response :success
  end
end
