class AddYearToResources < ActiveRecord::Migration[6.0]
  def change
    add_column :resources, :publication, :date
  end
end
