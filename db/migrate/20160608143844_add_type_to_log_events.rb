class AddTypeToLogEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :log_events, :type, :string
  end
end
