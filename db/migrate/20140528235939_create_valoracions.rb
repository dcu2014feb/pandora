class CreateValoracions < ActiveRecord::Migration
  def change
    create_table :valoracions do |t|
      t.integer :puntuacion
      t.integer :ldi_id
      t.integer :usuario_id

      t.timestamps
    end

    add_index :valoracions, [:ldi_id,:usuario_id], :unique => true
  end
end
