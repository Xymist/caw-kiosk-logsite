class AddJurisdictionIdToKiosks < ActiveRecord::Migration[5.0]
  def change
    add_column :kiosks, :jurisdiction_id, :integer
  end
end
