class RoutinesController < ApplicationController
  def index
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
