class Situado < ActiveRecord::Base
  belongs_to :ldi
  belongs_to :poblacion

  validates_uniqueness_of :ldi_id, :scope => :poblacion_id
end
