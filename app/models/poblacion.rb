class Poblacion < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  has_many :ldis

  validates :nombre, :presence => true
end