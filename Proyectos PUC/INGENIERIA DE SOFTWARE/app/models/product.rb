class Product < ApplicationRecord
    belongs_to :usuario, foreign_key: 'id_usuario', class_name: 'Usuario'
    belongs_to :categoria
    belongs_to :plataforma

    validates :estado, presence: true, inclusion: { in: ['publicado', 'pausado','vendido'] }
    validates :image, presence: true
    validates :nombre, presence: true
    validates :categoria, presence: true
    validates :plataforma, presence: true
    validates :usuario, presence: true
    validates_length_of :nombre, maximum: 255
    validates_length_of :descripcion, within: 50..1000, allow_blank: true

    def cambiar_estado(nuevo_estado)
        self.update(estado: nuevo_estado)
    end

    mount_uploader :image, ImageUploader
end
