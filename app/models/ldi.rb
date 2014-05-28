class Ldi < ActiveRecord::Base
  has_many :poblacions, :through => :situados
  has_many :situados

  validates :nombre, :presence => true
  validates :categoria, :presence => true, :inclusion => {:in => ["Bares y pubs", "Restaurantes", "Alojamientos", "Cultural", "Naturaleza"]}
  validates :descripcion, :presence => true
end
