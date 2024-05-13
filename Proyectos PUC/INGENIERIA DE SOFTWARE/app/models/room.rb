class Room < ApplicationRecord
    validates :name, presence: true
    belongs_to :usuario_1, foreign_key: "usuario_1_id", class_name: "Usuario"
    belongs_to :usuario_2, foreign_key: "usuario_2_id", class_name: "Usuario"
    scope :public_rooms, -> {where(is_private: false)}
    after_create_commit {broadcast_append_to 'rooms'}
    has_many :messages
end
