class CreateHeartbeats < ActiveRecord::Migration[5.0]
  def change
    create_table :heartbeats do |t|
      t.references :kiosk, foreign_key: true

      t.timestamps
    end
  end
end
