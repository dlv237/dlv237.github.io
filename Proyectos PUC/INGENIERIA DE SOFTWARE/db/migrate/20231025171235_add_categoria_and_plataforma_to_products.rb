class AddCategoriaAndPlataformaToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :categoria, null: false, foreign_key: true
    add_reference :products, :plataforma, null: false, foreign_key: true
  end
end
