require 'http'

class ExercisesController < ApplicationController
  BASE_URL = "https://wger.de/api/v2" 
  # https://wger.de/api/v2/exercise/
  def index
    # @exercises = Exercise.all
    # render :index
    # binding.pry 
    response = HTTP.follow(max_hops: 2).get("#{BASE_URL}/exercise") # response from API stored in the response variable
    if response.status.success?           
      @exercises = JSON.parse(response.body)['results'].map do |exercise| {name: exercise['name']}
      # binding.pry 
      end
      render json: @exercises
    else
      render json: { error: "Failed to fetch exercises" }
    end
  end 
    
  def show 
    response = HTTP.follow(max_hops: 2).get("#{BASE_URL}/exercise/#{params[:id]}")

    if response.status.success?
      @exercise = JSON.parse(response.body)
      render json: @exercise
    else  
      render json: { error: "Failed to fetch exercise details" }
    end
  end
end  