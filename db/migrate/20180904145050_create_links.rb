class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :name
      t.string :target
      t.string :owners

      t.timestamps
    end
  end
end
