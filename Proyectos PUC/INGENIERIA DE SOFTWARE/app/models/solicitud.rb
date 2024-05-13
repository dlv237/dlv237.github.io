class Solicitud < ApplicationRecord
    belongs_to :producto_ofrecido, foreign_key: "producto_ofrecido_id", class_name: "Product"
    belongs_to :producto_solicitado, foreign_key: "producto_solicitado_id", class_name: "Product"
    validates :mensaje, presence: true
    validates_length_of :mensaje, maximum: 255
    validates :estado, presence: true, inclusion: { in: [-1, 0, 1] }
end