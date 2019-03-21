# frozen_string_literal: true

class Bunny < ApplicationRecord
  include FightObjectConcern
  has_one :bunny_stat, dependent: :destroy

  has_many :fights, through: :bunny_fight_stats
  accepts_nested_attributes_for :bunny_stat
  validates_associated :bunny_stat
end
