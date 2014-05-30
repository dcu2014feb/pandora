class Poblacion < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  has_many :ldis, :through => :situados
  has_many :situados

  validates :nombre, :presence => true
end