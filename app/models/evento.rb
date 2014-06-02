class Evento < ActiveRecord::Base
	has_many :comentarios

	has_many :asig_eventos
	has_many :users, through: :asig_eventos
end
