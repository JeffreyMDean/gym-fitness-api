class RoutinesController < ApplicationController
  def index
    p "hello"
    p current_user
    @routines = Routine.all
    render json: @routines
  end

  def create
    @routine = Routine.create(
      user_id: current_user.id,
      exercise_id: params[:exercise_id],
      reps: params[:reps],
    )
    p @routine.errors
    render :show
  end
end
