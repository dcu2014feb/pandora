class AddImageToLdis < ActiveRecord::Migration
  def change
    add_column :ldis, :image, :string
  end
end
