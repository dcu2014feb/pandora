class AddMoreColumnsToPoblacions < ActiveRecord::Migration
  def change
    add_column :poblacions, :lat, :float
    add_column :poblacions, :long, :float
  end
end
