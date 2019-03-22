# frozen_string_literal: true

class WeaponStat < ApplicationRecord
  include StatConcern

  MAX_STOCK = 4
  MAX_VALUE = 2
  MIN_VALUE = 0

  belongs_to :weapon
  validates :life,
            :attack,
            :defense,
            :stamina,
            :luck,
            numericality: {
              greater_than_or_equal_to: MIN_VALUE,
              less_than_or_equal_to: MAX_VALUE
            }

  validate :validate_stock, on: :create
  validates_associated :weapon

  private

  def validate_stock
    stock = life + attack + defense + stamina + luck
    return if stock == MAX_STOCK

    errors.add(:stock, 'stock is not fully used')
  end

end
