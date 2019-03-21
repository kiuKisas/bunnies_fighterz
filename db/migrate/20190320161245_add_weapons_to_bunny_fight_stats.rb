class AddWeaponsToBunnyFightStats < ActiveRecord::Migration[5.2]
  def change
    create_table :bunny_fight_stats_weapons, id: false do |t|
      t.references :bunny_fight_stat, type: :uuid, null: false
      t.references :weapon, type: :uuid, null: false
    end
    add_index :bunny_fight_stats_weapons,
              %i[bunny_fight_stat_id weapon_id],
              name: :fight_stats_weapons
  end
end
