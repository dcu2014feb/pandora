class Comentario < ActiveRecord::Base
  belongs_to :ldi
  belongs_to :usuario

  validates :texto, :presence => true
end
