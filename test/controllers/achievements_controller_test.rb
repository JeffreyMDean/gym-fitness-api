require "test_helper"

class AchievementsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/achievements.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Achievement.count, data.length
  end
end
