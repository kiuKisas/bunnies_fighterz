class AddDamageTotalToBunnyFightStat < ActiveRecord::Migration[5.2]
  def change
    add_column :bunny_fight_stats, :damage_total, :integer
    add_column :bunny_fight_stats, :attack_total, :integer
    add_column :bunny_fight_stats, :attack, :integer
    remove_column :bunny_fight_stats, :total_attack
    remove_column :bunny_fight_stats, :succeed_attack
  end
end
