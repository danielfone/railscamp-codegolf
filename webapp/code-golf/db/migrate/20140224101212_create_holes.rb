class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.integer :length
      t.integer :par
      t.string :filename

      t.timestamps
    end
  end
end
