require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    assert_difference "Comment.count", 1 do
      post "/comments.json", params: { comment: { user_id: User.first.id, exercise_id: Exercise.first.id, body: "What a great exercise!"} }
      assert_response 201
    end
  end

  test "update" do
    comment = Comment.first
    patch "/comments/#{comment.id}.json", params: { comment: { user_id: User.first.id, exercise_id: Exercise.first.id, body: "Updated Body" } }
    assert_response 200

    data = JSON.parse(response.body)   
    assert_equal User.first.id, data["user_id"] 
    assert_equal Exercise.first.id, data["exercise_id"]
    assert_equal "Updated Body", data["body"]
  end
end

# After the update request is processed, the response is parsed from JSON into a Ruby hash ('data')...in the context of the test
# assert_equal method checks where the expected values match the actual values returned from the API (so checking new value from the response)
# data["user_id"] etc. access the values associated with these keys in that hash ('data' is a Ruby hash obtained by parsing the JSON reponse from the server)
# overall, purpose is to verify the PATCH request successfully updated the user_id attribute to the new value, and the the response correctly reflects this change

