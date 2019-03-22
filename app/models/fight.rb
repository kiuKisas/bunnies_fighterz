# frozen_string_literal: true

class Fight < ApplicationRecord
  has_many :bunny_fight_stats, dependent: :destroy
  has_many :bunnies, through: :bunny_fight_stats

  validates_associated :bunny_fight_stats, :bunnies
  validate :validate_bunny_fight_stats
  accepts_nested_attributes_for :bunny_fight_stats
  private

  def validate_bunny_fight_stats
    unless bunny_fight_stats.length == 2
      errors.add(:bunny_fight_stats_nbr, 'A fight should have two fighters')
    end
  end

end
