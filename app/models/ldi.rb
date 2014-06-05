class Ldi < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :poblacion

  belongs_to :usuario

  has_many :usuarios, :through => :valoracions
  has_many :valoracions

  has_many :usuarios, :through => :comentarios
  has_many :comentarios

  validates :nombre, :presence => true
  validates :categoria, :presence => true, :inclusion => {:in => ["bar_pub", "restaurante", "alojamiento", "cultural", "naturaleza"]}
  validates :descripcion, :presence => true
  validates :email, :presence => false
  validates :telefono, :format => {:with => /[[:digit:]]{9}/, :allow_blank => true}
  validates :cod_postal, :format => {:with => /[[:digit:]]{5}/, :allow_blank => true}
  validates :email, :format => { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :allow_blank => true}
  validates :poblacion_id, :presence => true
end
