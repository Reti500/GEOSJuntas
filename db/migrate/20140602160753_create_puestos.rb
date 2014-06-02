class CreatePuestos < ActiveRecord::Migration
  def change
    create_table :puestos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
