class AddLifeTotalToBunnyFightStat < ActiveRecord::Migration[5.2]
  def change
    add_column :bunny_fight_stats, :life_total, :integer
  end
end
