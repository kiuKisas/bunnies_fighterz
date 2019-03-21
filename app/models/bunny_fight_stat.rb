class BunnyFightStat < ApplicationRecord
  belongs_to :fight
  belongs_to :bunny
  has_and_belongs_to_many :weapons, optional: true

  LIFE_MAX = 100

  validates :life,
            :life_total,
            :attack,
            :attack_total,
            :damage,
            :damage_total,
            numericality: { greater_than_or_equal_to: 0 }

  validate :victory?
  validates_associated :bunny

  def victory?
    self.victory = true if life.positive?
  end
end
