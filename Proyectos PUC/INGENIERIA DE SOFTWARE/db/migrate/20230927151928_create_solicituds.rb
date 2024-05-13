class CreateSolicituds < ActiveRecord::Migration[7.0]
  def change
    create_table :solicituds do |t|
      t.references :producto_ofrecido, foreign_key: { to_table: :products }
      t.references :producto_solicitado, foreign_key: { to_table: :products }
      t.integer :estado
      t.string :mensaje, limit: 255

      t.timestamps
    end
  end
end
