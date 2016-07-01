class AddIpAddressToKiosks < ActiveRecord::Migration[5.0]
  def change
    add_column :kiosks, :ip_address, :string
  end
end
