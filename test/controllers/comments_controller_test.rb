require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    assert_difference "Comment.count", 1 do
      post "/comments.json", params: { user_id: User.first.id, exercise_id: Exercise.last.id, body: "This is an excellent body weight exercise. I've found it to be an essential part of my repertoire for at home workouts too!" }
      assert_response 200
    end
  end
end
