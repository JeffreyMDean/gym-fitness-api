class CommentsController < ApplicationController
  before_action :find_comment, only: [:update] # add :destroy

  def create
    @comment = Comment.new(comment_params)
    if @comment.save # saves the newly created comment obj to the db
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    logger.debug("Incoming params: #{params.inspect}")
    if @comment.update(comment_params)
      render json: @comment
    else 
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private 

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :exercise_id, :body)
  end

end
