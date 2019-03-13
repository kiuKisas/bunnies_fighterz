class CreateFights < ActiveRecord::Migration[5.2]
  def change
    create_table :fights, id: :uuid do |t|

      t.timestamps
    end
  end
end
