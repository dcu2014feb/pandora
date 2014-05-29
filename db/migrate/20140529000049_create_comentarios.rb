class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.text :texto
      t.integer :ldi_id
      t.integer :usuario_id

      t.timestamps
    end
  end
end
