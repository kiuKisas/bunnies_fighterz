# frozen_string_literal: true

class Bunny < ApplicationRecord
  has_one :bunny_stat, dependent: :destroy
  has_many :bunny_fight_stats
  has_many :fights, through: :bunny_fight_stats

  accepts_nested_attributes_for :bunny_stat
  validates :name, presence: true, length: { minimum: 0, maximum: 50 }
  validates_associated :bunny_stat
end
