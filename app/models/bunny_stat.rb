# frozen_string_literal: true

class BunnyStat < ApplicationRecord
  #include StatConcern

  MAX_STOCK = 20
  MAX_VALUE = 9
  MIN_VALUE = 1

  belongs_to :bunny
  validates :life,
            :attack,
            :defense,
            :stamina,
            :luck,
            numericality: {
              greater_than_or_equal_to: self::MIN_VALUE,
              less_than_or_equal_to: self::MAX_VALUE
            }

  validate :validate_stock, on: :create

  private

  def validate_stock
    stock = life + attack + defense + stamina + luck
    return if stock == BunnyStat::MAX_STOCK

    errors.add(:stock, 'stock is not fully used')
  end
end
