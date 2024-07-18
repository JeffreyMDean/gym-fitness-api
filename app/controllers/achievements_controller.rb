class AchievementsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @achievements = current_user.achievements
    render json: @achievements
  end
end
