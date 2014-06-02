class CreateAsigEventos < ActiveRecord::Migration
  def change
    create_table :asig_eventos do |t|
      t.integer :user_id
      t.integer :evento_id

      t.timestamps
    end
  end
end
