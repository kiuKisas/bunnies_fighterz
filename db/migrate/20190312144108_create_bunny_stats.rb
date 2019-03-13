class CreateBunnyStats < ActiveRecord::Migration[5.2]
  def change
    create_table :bunny_stats, id: :uuid do |t|
      t.integer :life
      t.integer :attack
      t.integer :defense
      t.integer :stamina
      t.integer :luck
      t.references :bunny,
                   type: :uuid,
                   foreign_key: true

      t.timestamps
    end
  end
end
