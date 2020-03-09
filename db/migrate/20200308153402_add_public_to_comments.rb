class AddPublicToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :public, :boolean
  end
end
