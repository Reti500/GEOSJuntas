class AsigEvento < ActiveRecord::Base
	belongs_to :user
	belongs_to :evento
end
