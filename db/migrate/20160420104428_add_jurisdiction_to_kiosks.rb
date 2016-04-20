class AddJurisdictionToKiosks < ActiveRecord::Migration[5.0]
  def change
    add_column :kiosks, :jurisdiction, :string
  end
end
