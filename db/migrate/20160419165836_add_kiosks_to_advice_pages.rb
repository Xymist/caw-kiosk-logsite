class AddKiosksToAdvicePages < ActiveRecord::Migration[5.0]
  def change
    add_column :advice_pages, :kiosks, :text
    add_column :advice_pages, :topic, :string
  end
end
