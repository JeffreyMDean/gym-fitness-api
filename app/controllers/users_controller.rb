class UsersController < ApplicationController
  def index
    @users = User.all 
    render json: @users, status: :ok
  end            #the array of user objects retrieved earlier

  def show
    @user = User.find_by(id: params[:id])
    render json: @user, status: :ok
  end

  def create 
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end
 
  def update
    @user = User.find_by(id: params[:id])
    if @user.update(
      name: params[:name] || @user.name,
      email: params[:email] || @user.email,
      password: params[:password].presence || @user.password,
      password_confirmation: params[:password_confirmation].presence || @user.password_confirmation
    )
      render json: { message: "User updated successfully" }, status: :ok 
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request 
    end
  end
end
