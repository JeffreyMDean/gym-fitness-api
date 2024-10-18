class RoutinesController < ApplicationController
  def index
    @routines = Routine.all
    render json: @routines 
  end

  def create
    if current_user
      @routine = Routine.create(
        user_id: current_user.id,
        exercise_id: params[:exercise_id],
        reps: params[:reps],
      )
      if @routine.save
        render json: @routine, status: :created
      else
        render json: @routine.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Not authenticated' }, status: :unauthorized
    end
  end 
end
