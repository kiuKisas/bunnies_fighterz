# frozen_string_literal: true

class BunnyStat < ApplicationRecord
  belongs_to :bunny

  MAX_PTS = 15

  LIFE = 355
  ATTACK = 200
  DEFENSE = 200
  STAMINA = 100
  LUCK = 100
end
