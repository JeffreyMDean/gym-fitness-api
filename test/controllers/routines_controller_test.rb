require "test_helper"

class RoutinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @exercise = exercises(:one)
    sign_in @user
  end

  test "index" do
    get "/routines.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Routine.count, data.length
  end

  test "create" do
    assert_difference "Routine.count", 1 do
      post "/routines.json", params: { exercise_id: @exercise.id, reps: 20 }
      assert_response 200
    end 
  end
end 
