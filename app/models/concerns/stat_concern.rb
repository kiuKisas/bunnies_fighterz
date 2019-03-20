# frozen_string_literal: true

module StatConcern
  extend ActiveSupport::Concern

  included do
    validates :life,
              :attack,
              :defense,
              :stamina,
              :luck,
              numericality: {
                greater_than_or_equal_to: 0,
                less_than_or_equal_to: MAX_VALUE
              }

    validate :validate_stock, on: :create
  end

  private

  def validate_stock
    stock = life + attack + defense + stamina + luck
    return if stock == MAX_STOCK

    errors.add(:stock, 'stock is not fully used')
  end
end
