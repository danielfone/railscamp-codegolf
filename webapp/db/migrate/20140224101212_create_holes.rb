class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.integer :length
      t.integer :best
      t.string :name

      t.timestamps
    end
  end
end
