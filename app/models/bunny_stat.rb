# frozen_string_literal: true

class BunnyStat < ApplicationRecord
  belongs_to :bunny

  MAX_STOCK = 20

  validate :validate_stock, on: %i[create update]

  private

  def validate_stock
    stock = life + attack + defense + stamina + luck
    stock == MAX_STOCK
  end
end
