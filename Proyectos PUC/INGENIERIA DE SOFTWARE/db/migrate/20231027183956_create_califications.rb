class CreateCalifications < ActiveRecord::Migration[7.0]
  def change
    create_table :califications do |t|
      t.references :usuario_calificador, null: false, foreign_key: { to_table: :usuarios }
      t.references :usuario_calificado, null: false, foreign_key: { to_table: :usuarios }
      t.integer :puntuacion
      t.text :mensaje
      t.references :product, null: false, foreign_key: true, foreign_key: {to_table: :products}

      t.timestamps
    end
  end
end
