class AddEmailToJurisdiction < ActiveRecord::Migration[5.0]
  def change
    add_column :jurisdictions, :email, :text
  end
end
