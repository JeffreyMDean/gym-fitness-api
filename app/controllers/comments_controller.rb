class CommentsController < ApplicationController
  before_action :set_comment, only: [:update] # add :destroy

  def create
    @comment = Comment.new(comment_params)
    if @comment.save # saves the newly created comment obj to the db
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else 
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private 

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :exercise_id, :body)
  end

end
