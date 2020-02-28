class AddBodyToQuotes < ActiveRecord::Migration[6.0]
  def change
    add_column :quotes, :body, :text
  end
end
