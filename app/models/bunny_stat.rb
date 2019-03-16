# frozen_string_literal: true

class BunnyStat < ApplicationRecord
  belongs_to :bunny

  MAX_STOCK = 20

  validates :life,
            :attack,
            :defense,
            :stamina,
            :luck,
            numericality: { greater_than: 0, less_than: 10 }

  validate :validate_stock, on: :create

  private

  def validate_stock
    stock = life + attack + defense + stamina + luck
    return if stock == MAX_STOCK

    errors.add(:stock, 'stock is not fully used')
  end
end
