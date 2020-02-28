class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.string :title
      t.string :author
      t.string :source
      t.text :commentary
      t.boolean :public

      t.timestamps
    end
  end
end
