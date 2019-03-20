# frozen_string_literal: true

class BunnyStat < ApplicationRecord
  include StatConcern

  MAX_STOCK = 20
  MAX_VALUE = 9

  belongs_to :bunny
end
