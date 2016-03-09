class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :location
      t.belongs_to :host, index: true

      t.timestamps
    end
  end
end
