class AddOtherColumnToLdis < ActiveRecord::Migration
  def change
    add_column :ldis, :direccion, :string
    add_column :ldis, :cod_postal, :string
  end
end
