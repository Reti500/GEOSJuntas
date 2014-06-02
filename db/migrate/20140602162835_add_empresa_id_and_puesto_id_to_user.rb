class AddEmpresaIdAndPuestoIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :empresa_id, :integer
    add_column :users, :puesto_id, :integer
  end
end
