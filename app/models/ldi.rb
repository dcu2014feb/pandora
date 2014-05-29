class Ldi < ActiveRecord::Base
  has_many :poblacions, :through => :situados
  has_many :situados

  has_many :usuarios, :through => :valoracions
  has_many :valoracions

  has_many :usuarios, :through => :comentarios
  has_many :comentarios

  validates :nombre, :presence => true
  validates :categoria, :presence => true, :inclusion => {:in => ["Bares y pubs", "Restaurantes", "Alojamientos", "Cultural", "Naturaleza"]}
  validates :descripcion, :presence => true
end
