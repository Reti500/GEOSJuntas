class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.integer :evento_id
      t.integer :user_id
      t.string :titulo
      t.string :comentario

      t.timestamps
    end
  end
end
