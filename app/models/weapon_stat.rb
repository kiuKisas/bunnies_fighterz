# frozen_string_literal: true

class WeaponStat < ApplicationRecord
  include StatConcern

  MAX_STOCK = 4
  MAX_VALUE = 2

  belongs_to :weapon
end
