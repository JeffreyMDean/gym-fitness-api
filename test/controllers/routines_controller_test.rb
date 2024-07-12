require "test_helper"

class RoutinesControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/routines.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Routine.count, data.length
  end

  test "create" do
    assert_difference "Routine.count", 1 do
      post "/routines.json", params: { user_id: User.first.id, exercise_id: Exercise.first.id, reps: 20 }
      assert_response 200
    end
  end
end 
