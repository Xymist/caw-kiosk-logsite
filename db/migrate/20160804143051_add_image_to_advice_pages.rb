class AddImageToAdvicePages < ActiveRecord::Migration[5.0]
  def change
    add_column :advice_pages, :image, :oid
  end
end
