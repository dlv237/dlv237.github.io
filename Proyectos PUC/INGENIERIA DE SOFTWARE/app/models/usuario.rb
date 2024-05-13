class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
    belongs_to :region
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    has_many :products
    has_many :messages
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable, :lockable
    validates :email, presence: true
    validates :nombre, presence: true
    validates :region, presence: true
    # validates :password, presence: true

  # Profile image
    mount_uploader :avatar, AvatarUploader

end
