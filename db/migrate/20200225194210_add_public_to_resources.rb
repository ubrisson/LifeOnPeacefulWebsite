class AddPublicToResources < ActiveRecord::Migration[6.0]
  def change
    add_column :resources, :public, :boolean
  end
end
