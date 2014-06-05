class Comentario < ActiveRecord::Base
	belongs_to :evento
	belongs_to :user
end
