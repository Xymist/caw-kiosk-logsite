class AddKioskToFormResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :form_responses, :kiosk_id, :integer, null: false
    add_index  :form_responses, :kiosk_id
  end
end
