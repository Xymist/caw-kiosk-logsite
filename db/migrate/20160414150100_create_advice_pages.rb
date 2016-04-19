class CreateAdvicePages < ActiveRecord::Migration[5.0]
  def change
    create_table :advice_pages do |t|
      t.string :organisation
      t.string :url
      t.string :telephone
      t.string :details

      t.timestamps
    end
  end
end
