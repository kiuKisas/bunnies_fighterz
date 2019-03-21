# frozen_string_literal: true

class BunnyStat < ApplicationRecord
  #include StatConcern

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
            }

  validate :validate_stock, on: :create

  def to_map
    self
      .attributes
      .symbolize_keys
      .delete_if { |k| [:updated_at, :created_at, :id, :bunny_id].include?(k) }
  end
  private

  def validate_stock
    stock = life + attack + defense + stamina + luck
    return if stock == BunnyStat::MAX_STOCK

    errors.add(:stock, 'stock is not fully used')
  end
end
