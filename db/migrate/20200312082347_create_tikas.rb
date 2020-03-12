class CreateTikas < ActiveRecord::Migration[6.0]
  def change
    create_table :tikas do |t|
      t.string :title
      t.string :link
      t.string :year

      t.timestamps
    end
  end
end
