class CreateLdis < ActiveRecord::Migration
  def change
    create_table :ldis do |t|
      t.string :nombre
      t.string :categoria
      t.text :descripcion
      t.string :telefono
      t.string :email

      t.timestamps
    end
  end
end
