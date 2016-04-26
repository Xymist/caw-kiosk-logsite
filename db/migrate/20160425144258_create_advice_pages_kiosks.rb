class CreateAdvicePagesKiosks < ActiveRecord::Migration[5.0]
  def change
    create_table :advice_pages_kiosks, id: false do |t|
      t.belongs_to :advice_page, index: true
      t.belongs_to :kiosk, index: true
    end
  end
end
