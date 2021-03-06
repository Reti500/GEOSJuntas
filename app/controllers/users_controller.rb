class UsersController < ApplicationController
  def index
  	search = params[:search] || nil
  	
  	if search
  		@users = User.search(search)
  	else
  		@users = User.all
  	end

  	render json: @users
  end

  def search
  	search = params[:search] || nil

  	if search
  		@users = User.search(search)
  	else
  		@users = []
  	end

  	render json: @users
  end
end
