class AddDescriptionToKioskTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :kiosk_topics, :description, :string
  end
end
