class NotificationsController < ApplicationController

	def index
		render json: current_user.notifications
	end

end
