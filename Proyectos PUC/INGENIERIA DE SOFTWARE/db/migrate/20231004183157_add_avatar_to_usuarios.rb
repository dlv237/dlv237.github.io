class AddAvatarToUsuarios < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :avatar, :string
  end
end
