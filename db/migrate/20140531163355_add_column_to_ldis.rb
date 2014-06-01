class AddColumnToLdis < ActiveRecord::Migration
  def change
    add_column :ldis, :poblacion_id, :integer
    add_column :ldis, :usuario_id, :integer
  end
end
