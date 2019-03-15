# frozen_string_literal: true

class CreateBunnyFightStats < ActiveRecord::Migration[5.2]
  def change
    create_table :bunny_fight_stats, id: :uuid do |t|
      t.boolean :victory

      t.integer :life
      t.integer :total_attack
      t.integer :succeed_attack
      t.integer :damage

      t.references :bunny,
                   type: :uuid,
                   foreign_key: true

      t.timestamps
    end
  end
end
