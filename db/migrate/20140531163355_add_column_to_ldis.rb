class AddColumnToLdis < ActiveRecord::Migration
  def change
    add_column :ldis, :poblacion_id, :integer
  end
end
