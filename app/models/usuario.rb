class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable
  # ,:recoverable, :rememberable, :trackable, :validatable

  mount_uploader :image, ImageUploader

  validates :nombre, :presence => true
  validates :email, :presence => true, :format =>  {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates_confirmation_of :password

  has_many :ldis

  has_many :ldis, :through => :valoracions
  has_many :valoracions

  has_many :ldis, :through => :comentarios
  has_many :comentarios
end
