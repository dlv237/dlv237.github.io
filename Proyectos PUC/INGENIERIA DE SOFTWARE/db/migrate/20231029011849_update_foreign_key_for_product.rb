class UpdateForeignKeyForProduct < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :califications, :products
    add_foreign_key :califications, :products, on_delete: :cascade

    remove_foreign_key :solicituds, :products, column: :producto_ofrecido_id
    remove_foreign_key :solicituds, :products, column: :producto_solicitado_id
    
    add_foreign_key :solicituds, :products, column: :producto_ofrecido_id, on_delete: :cascade
    add_foreign_key :solicituds, :products, column: :producto_solicitado_id, on_delete: :cascade
  end
end
