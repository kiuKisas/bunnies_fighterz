class AddWeaponsToBunnyFightStats < ActiveRecord::Migration[5.2]
  def change
    add_reference :bunny_fight_stats,
                  :weapon,
                  type: :uuid,
                  foreign_key: true
  end
end
