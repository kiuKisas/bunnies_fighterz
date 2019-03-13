# frozen_string_literal: true

class Bunny < ApplicationRecord
  has_one :bunny_stat
  accepts_nested_attributes_for :bunny_stat
end
