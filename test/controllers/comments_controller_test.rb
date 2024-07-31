require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    assert_difference "Comment.count", 1 do
      post "/comments.json", params: { comment: { user_id: User.first.id, exercise_id: Exercise.first.id, body: "What a great exercise!"} }
      assert_response 201
    end
  end
end
