class CreateKioskTopicsJurisdictions < ActiveRecord::Migration[5.0]
  def change
    create_table :jurisdictions_kiosk_topics, :id => false do |t|
      t.integer :kiosk_topic_id
      t.integer :jurisdiction_id
    end
  end
end
