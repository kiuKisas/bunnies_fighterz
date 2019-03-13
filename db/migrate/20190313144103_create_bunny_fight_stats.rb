# frozen_string_literal: true

class CreateBunnyFightStats < ActiveRecord::Migration[5.2]
  def change
    create_table :bunny_fight_stats, id: :uuid do |t|
      t.boolean :victory

      t.integer :total_nbr_attack
      t.integer :succeed_attack
      t.integer :average_attack
      t.integer :total_domage
      t.integer :receive_domage

      t.references :bunny,
                   type: :uuid,
                   index: { unique: true },
                   foreign_key: true

      t.references :fight,
                   type: :uuid,
                   index: { unique: true },
                   foreign_key: true

      t.timestamps
    end
  end
end
