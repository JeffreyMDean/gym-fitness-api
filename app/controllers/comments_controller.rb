class CommentsController < ApplicationController
  def create
    @comment = Comment.create(
      user_id: params[:user_id],
      exercise_id: params[:exercise_id],
      body: params[:body],
    )
    render :show
  end
end
