require 'http'

class ExercisesController < ApplicationController
  BASE_URL = "https://wger.de/api/v2" 
  # https://wger.de/api/v2/exercise/
  def index
    # @exercises = Exercise.all
    # render :index
    # binding.pry 
    response = HTTP.follow(max_hops: 2).get("https://wger.de/api/v2/exercise") # response from API stored in the response variable
    if response.status.success?           
      @exercises = JSON.parse(response.body)['results'].map do |exercise| {name: exercise['name']}
      # binding.pry 
      end
      render json: @exercises
    else
      render json: {error: "Failed to fetch"}
    end
  end 
    
  def show 
    @exercise = Exercise.find_by(id: params[:id])
    render :show 
  end
end  