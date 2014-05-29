class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable
  # ,:recoverable, :rememberable, :trackable, :validatable

  validates :nombre, :presence => true

  has_many :ldis, :through => :valoracions
  has_many :valoracions

  has_many :ldis, :through => :comentarios
  has_many :comentarios
end
