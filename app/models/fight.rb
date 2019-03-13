# frozen_string_literal: true

class Fight < ApplicationRecord
  has_many :bunny_fight_stats
  has_many :bunnies, through: :bunny_fight_stats
end
