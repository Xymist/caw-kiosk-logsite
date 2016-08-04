class AddHasButtonLogosToJurisdictions < ActiveRecord::Migration[5.0]
  def change
    add_column :jurisdictions, :has_button_logos, :boolean, :null => false, :default => false
  end
end
