class AddIndexToSituados < ActiveRecord::Migration
  def change
    add_index :situados, [:poblacion_id, :ldi_id], :unique => true
  end
end
