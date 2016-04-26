class CreateLogEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :log_events do |t|
      t.string :log_caller
      t.string :event

      t.timestamps
    end
  end
end
