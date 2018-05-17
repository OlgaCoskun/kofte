class AddPincodeToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :pincode, :string
  end
end
