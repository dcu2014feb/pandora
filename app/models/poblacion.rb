class Poblacion < ActiveRecord::Base
  has_many :ldis, :through => :situados
  has_many :situados

  validates :nombre, :presence => true
end