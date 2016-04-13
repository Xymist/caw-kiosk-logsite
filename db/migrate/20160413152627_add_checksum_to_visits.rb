class AddChecksumToVisits < ActiveRecord::Migration[5.0]
  def change
    add_column :visits, :checksum, :string
    add_index :visits, :checksum, unique: true
    add_index :visits, [:time_stamp, :kiosk_id], unique: true
  end
end
