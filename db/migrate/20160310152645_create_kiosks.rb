class CreateKiosks < ActiveRecord::Migration[5.0]
  def change
    create_table :kiosks do |t|
      t.string :name
      t.string :address
      t.string :contact

      t.timestamps
    end
  end
end
