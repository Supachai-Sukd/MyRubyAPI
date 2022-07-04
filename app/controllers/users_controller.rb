class UsersController < ApplicationController
  def index
    users = User.all
    render json: users.as_json
  end

  def create
    user = User.new
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.save
    render json: user.as_json
  end

  def show
    user = User.find(params[:id])
    render json: user.as_json
  end

  def update
    user = User.find(params[:id])
    user.first_name = params[:first_name] if params[:first_name].present?
    user.last_name = params[:last_name] if params[:last_name].present?
    user.save
    render json: user.as_json
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { success: true }
  end
end
