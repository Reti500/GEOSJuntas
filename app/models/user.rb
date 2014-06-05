class User < ActiveRecord::Base
  authenticates_with_sorcery!

  belongs_to :empresa
  belongs_to :puesto

  has_many :comentarios
  has_many :asig_eventos
  has_many :eventos, through: :asig_eventos
end
