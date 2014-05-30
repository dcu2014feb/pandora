class AddImageToPoblacions < ActiveRecord::Migration
  def change
    add_column :poblacions, :image, :string
  end
end
