class RemoveJurisdictionFromKiosks < ActiveRecord::Migration[5.0]
  def change
    remove_column :kiosks, :jurisdiction
  end
end
