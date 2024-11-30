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

# .all is an activeRecord query method that retrieves all records from the routines table in the database (in this case)
# .save is an activeRecord method that attempts to save the @routine object to the database
# current_user.id accesses the id attribute of that User object, which is typically the primary key in the database...basically it is used to set the user_id attribute on the new Routine instance, which effectively associates this routine with the logged-in user
# in database terms, it's creating a relationship between the Routine record and the User record, where: a user can have many routines (one-to-many relationship) and a routine belongs to a user (through the user_id).....So, by setting user_id: current_user.id, you're linkings this routine to the authenticated user
