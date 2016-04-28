class CreateJurisdictionsLogos < ActiveRecord::Migration[5.0]
  def change
    create_table :jurisdictions_logos, id: false do |t|
      t.belongs_to :jurisdiction, index: true
      t.belongs_to :logo, index: true
    end
  end
end
