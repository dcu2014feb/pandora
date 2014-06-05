class Valoracion < ActiveRecord::Base
  belongs_to :ldi
  belongs_to :usuario

  validates :puntuacion, :presence => true, :format => {:with => /[0-5]/}
  validates_uniqueness_of :ldi_id, :scope => :usuario_id
end
