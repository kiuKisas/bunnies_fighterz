# frozen_string_literal: true

class BunnyStat < ApplicationRecord
  include StatConcern

  MAX_STOCK = 15
  MAX_VALUE = 7
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
            },
            on: :create

  validate :validate_stock, on: :create
  validates_associated :bunny

  private

  def validate_stock
    stock = life + attack + defense + stamina + luck
    return if stock == MAX_STOCK

    errors.add(:stock, 'stock is not fully used')
  end
end
