class DropLabelDescriptionFromKiosks < ActiveRecord::Migration[5.0]
  def change
    remove_column :kiosk_topics, :label
    remove_column :kiosk_topics, :description
  end
end
