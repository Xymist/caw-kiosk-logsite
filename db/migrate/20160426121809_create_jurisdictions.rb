class CreateJurisdictions < ActiveRecord::Migration[5.0]
  def change
    create_table :jurisdictions do |t|
      t.string :name
      t.boolean :telephone
      t.string :pbx_server

      t.timestamps
    end
  end
end
