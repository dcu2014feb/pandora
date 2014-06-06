class AddMoreColumnsToLdis < ActiveRecord::Migration
  def change
    add_column :ldis, :lat, :float
    add_column :ldis, :long, :float
  end
end
