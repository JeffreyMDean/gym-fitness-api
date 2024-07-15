class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @comment = Comment.create(
      user_id: params[:user_id],
      exercise_id: params[:exercise_id],
      body: params[:body],
    )
    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :exercise_id, :body)
  end
end
