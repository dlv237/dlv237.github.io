class Region < ApplicationRecord
    has_many :usuarios
    validates :nombre, presence: true
end
