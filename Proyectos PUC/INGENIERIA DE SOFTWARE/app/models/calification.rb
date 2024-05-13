class Calification < ApplicationRecord
    belongs_to :usuario_calificador, class_name: 'Usuario', foreign_key: 'usuario_calificador_id'
    belongs_to :usuario_calificado, class_name: 'Usuario', foreign_key: 'usuario_calificado_id'
    belongs_to :product
    validates :puntuacion, presence: true
end
