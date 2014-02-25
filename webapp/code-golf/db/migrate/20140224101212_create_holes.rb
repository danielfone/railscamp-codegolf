class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.integer :length
      t.integer :best
      t.string :filename

      t.timestamps
    end
  end
end
