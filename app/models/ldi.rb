class Ldi < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  has_many :poblacions, :through => :situados
  has_many :situados

  has_many :usuarios, :through => :valoracions
  has_many :valoracions

  has_many :usuarios, :through => :comentarios
  has_many :comentarios

  validates :nombre, :presence => true
  validates :categoria, :presence => true, :inclusion => {:in => ["bar_pub", "restaurante", "alojamiento", "cultural", "naturaleza"]}
  validates :descripcion, :presence => true
end
