class BunnyFightStat < ApplicationRecord
  belongs_to :fight
  belongs_to :bunny

  LIFE_MAX = 100

  validates :life,
            :life_total,
            :total_attack,
            :succeed_attack,
            :damage,
            numericality: { greater_than_or_equal_to: 0 }

  validate :victory?
  validates_associated :bunny

  def victory?
    self.victory = true if life.positive?
  end
end
