class AddTotalToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :total, :integer, index: true
  end
end
