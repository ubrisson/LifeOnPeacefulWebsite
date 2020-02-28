class ChangeResourcesDescription < ActiveRecord::Migration[6.0]
  def change
    change_column :resources, :description, :text
  end
end
