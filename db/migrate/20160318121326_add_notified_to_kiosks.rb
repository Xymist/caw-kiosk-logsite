class AddNotifiedToKiosks < ActiveRecord::Migration[5.0]
  def change
    add_column :kiosks, :notified, :boolean
  end
end
