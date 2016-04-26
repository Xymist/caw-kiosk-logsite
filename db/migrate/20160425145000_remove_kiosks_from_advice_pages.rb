class RemoveKiosksFromAdvicePages < ActiveRecord::Migration[5.0]
  def change
    remove_column :advice_pages, :kiosks
  end
end
