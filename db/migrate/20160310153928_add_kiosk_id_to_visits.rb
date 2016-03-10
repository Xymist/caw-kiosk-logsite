class AddKioskIdToVisits < ActiveRecord::Migration[5.0]
  def change
    add_column :visits, :kiosk_id, :integer
    remove_column :visits, :kiosk
  end
end
