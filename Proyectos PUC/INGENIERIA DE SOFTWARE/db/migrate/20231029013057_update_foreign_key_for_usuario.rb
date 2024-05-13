class UpdateForeignKeyForUsuario < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :califications, :usuarios, column: :usuario_calificado_id
    remove_foreign_key :califications, :usuarios, column: :usuario_calificador_id
    
    add_foreign_key :califications, :usuarios, column: :usuario_calificado_id, on_delete: :cascade
    add_foreign_key :califications, :usuarios, column: :usuario_calificador_id, on_delete: :cascade

    remove_foreign_key :messages, :usuarios
    add_foreign_key :messages, :usuarios, on_delete: :cascade

    remove_foreign_key :rooms, :usuarios, column: :usuario_1_id
    remove_foreign_key :rooms, :usuarios, column: :usuario_2_id

    add_foreign_key :rooms, :usuarios, column: :usuario_1_id, on_delete: :cascade
    add_foreign_key :rooms, :usuarios, column: :usuario_2_id, on_delete: :cascade
  end
end
