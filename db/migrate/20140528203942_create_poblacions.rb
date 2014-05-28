class CreatePoblacions < ActiveRecord::Migration
  def change
    create_table :poblacions do |t|
      t.string :nombre
      t.text :descripcion

      t.timestamps
    end
  end
end
