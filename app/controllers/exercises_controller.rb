require 'http'

class ExercisesController < ApplicationController
  BASE_URL = "https://wger.de/api/v2" 
  def index
    @exercises = Exercise.all
    render :index
    # response = HTTP.get("https://pokeapi.co/api/v2")
    # puts 'TEST #{response}'
    # if response.status.success?
    #   JSON.parse(response.body.to_s)
    # else
    #   render json: { error: 'Failed request' }
    # end
  end
    
  def show
    @exercise = Exercise.find_by(id: params[:id])
    render :show
  end
end
