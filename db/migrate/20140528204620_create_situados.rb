class CreateSituados < ActiveRecord::Migration
  def change
    create_table :situados do |t|
      t.string :direccion
      t.string :cod_postal
      t.integer :poblacion_id
      t.integer :ldi_id

      t.timestamps
    end
  end
end
