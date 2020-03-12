class AddAncestryToTikas < ActiveRecord::Migration[6.0]
  def change
    add_column :tikas, :ancestry, :string
    add_index :tikas, :ancestry
  end
end
