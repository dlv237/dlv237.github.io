class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :nombre, limit: 255
      t.text :descripcion
      t.string :estado, limit: 255
      t.integer :id_categoria
      t.integer :id_usuario
      t.timestamps
    end
  end
end
