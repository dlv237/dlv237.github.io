class AddRegionToUsuarios < ActiveRecord::Migration[7.0]
  def change
    add_reference :usuarios, :region, foreign_key: true
  end
end
