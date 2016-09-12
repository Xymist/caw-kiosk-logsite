class CreateVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :visits do |t|
      t.datetime :time_stamp
      t.string :kiosk
      t.belongs_to :topic, index: true

      t.timestamps
    end
  end
end
