class User < ActiveRecord::Base
  authenticates_with_sorcery!

  belongs_to :empresa
  belongs_to :puesto

  has_many :comentarios
  has_many :notifications
  has_many :asig_eventos
  has_many :eventos, through: :asig_eventos

  def self.search(search)
  	wildcard_search = "%#{search}%"

  	where("email LIKE :search or name LIKE :search", search: wildcard_search)
  end
end
