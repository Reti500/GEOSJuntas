class AddDuracionToEventos < ActiveRecord::Migration
  def change
    add_column :eventos, :duracion, :integer
  end
end
