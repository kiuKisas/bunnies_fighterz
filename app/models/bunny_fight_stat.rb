class BunnyFightStat < ApplicationRecord
  belongs_to :fight
  belongs_to :bunny
  has_and_belongs_to_many :weapons, optional: true

  attr_accessor :context

  LIFE_MAX = 100

  validates_associated :bunny

  validates :life,
            :life_total,
            :attack,
            :attack_total,
            :damage,
            :damage_total,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 },
            unless: :init?

  def victory?
    self.victory = true if life&.positive?
  end

  private

  def init?
    context == :init
  end
end
