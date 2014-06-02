class SessionsController < ApplicationController
  def create
  	user = login(params[:email], params[:password], params[:remember_me])

  	respond_to do |format|
  		if user
			format.html { redirect_back_or_to forms_url, :notice => "Logged in!" }
			format.json { render json: {state:"Logged"} }
		else
			flash.now.alert = "Email or password was invalid"
			format.html { render :new }
			format.json { render json: {state:"Error"} }
		end
  	end
  end

  def destroy
  	logout
  	respond_to do |format|
  		format.html {}
  		format.json { render json: {state: "Logout"} }
  	end
  end
end
