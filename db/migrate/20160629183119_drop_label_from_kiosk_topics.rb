class DropLabelFromKioskTopics < ActiveRecord::Migration[5.0]
  def change
    remove_column :kiosk_topics, :label
  end
end
