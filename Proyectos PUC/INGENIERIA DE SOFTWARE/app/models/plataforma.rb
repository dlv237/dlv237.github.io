class Plataforma < ApplicationRecord
    has_many :products
    validates :nombre, presence: true
end
