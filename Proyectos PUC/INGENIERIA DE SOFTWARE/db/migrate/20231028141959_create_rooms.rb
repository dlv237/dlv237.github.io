class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.boolean :is_private, default: false
      t.references :usuario_1, foreign_key: { to_table: :usuarios }
      t.references :usuario_2, foreign_key: { to_table: :usuarios }
      t.timestamps
    end
  end
end
