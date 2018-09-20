class AddCounter < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :counter, :int, :default => 0
  end
end
