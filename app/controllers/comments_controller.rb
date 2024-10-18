class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy] 

  def create
    @comment = Comment.new(comment_params)
    if @comment.save 
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

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment
      @comment.destroy
      render json: { message: "Comment destroyed successfully" }, status: :ok
    else
      render json: { error: "Comment not found" }, status: :not_found
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
# params.require(:comment) accesses the nested comment hash and extracts the nested hash associated with the :comment key..."user_id: 1", etc.
# after requiring the :comment key, permit(:user_id, etc.) specifies which attributes are allowed for mass assignment.
# comment is the key representing a hash of parameters related to a Comment
# user_id etc. are parameters (or sub-keys) within that comment hash
                  # attributes 
# When submitting a form, the data sent in the request to the server is referred to as parameters (what you get from the user input or API requests)
# Attributes are the properties of a model. When you store or work with this data in the models or database, those pieces of data are called attributes (what you define in your model to structure and store the  data) 
# Overall when you fill out a form and submit it, the data (:user_id, :exercise_id, :body) is sent as parameters. The controller receives these parameters and processes them. When creating or updating a Comment, the user_id, exercise_id, and body are attributes of the Comment model  
