class CreateLogos < ActiveRecord::Migration[5.0]
  def change
    create_table :logos do |t|
      t.column :image, :oid, :null => false
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
