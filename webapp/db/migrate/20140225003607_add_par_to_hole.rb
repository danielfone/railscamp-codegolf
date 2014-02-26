class AddParToHole < ActiveRecord::Migration
  def change
    add_column :holes, :par, :integer
  end
end
