class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.string :type
      t.string :title
      t.text :body
      t.string :author
      t.string :source

      t.timestamps
    end
    add_index :contents, :created_at
  end
end
