class AsigEvento < ActiveRecord::Base
	belongs_to :user
	belongs_to :evento

	validates_uniqueness_of :user_id, :scope => [:evento_id]
end
