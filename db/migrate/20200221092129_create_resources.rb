class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.string :title
      t.string :description
      t.string :link
      t.string :author

      t.timestamps
    end
  end
end
