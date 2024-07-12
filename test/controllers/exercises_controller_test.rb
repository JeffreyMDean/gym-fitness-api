require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/exercises.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Exercise.count, data.length
  end

  test "show" do
    get "/exercises/#{Exercise.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "name", "description", "image_url", "video_url", "created_at", "updated_at"], data.keys
  end
end 
