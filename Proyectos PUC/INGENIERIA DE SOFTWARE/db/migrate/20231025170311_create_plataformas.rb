class CreatePlataformas < ActiveRecord::Migration[7.0]
  def change
    create_table :plataformas do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
