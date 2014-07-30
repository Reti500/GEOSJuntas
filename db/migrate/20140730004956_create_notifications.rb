class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :message
      t.string :action
      t.string :notify_type

      t.timestamps
    end
  end
end
