class AddInfoToUser < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string, :default => nil
  	add_column :users, :empleyee_number, :integer, :default => nil
  end
end
