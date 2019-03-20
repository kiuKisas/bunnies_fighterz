# frozen_string_literal: true

module FightObjectConcern
  extend ActiveSupport::Concern

  included do
    has_many :bunny_fight_stats, dependent: :destroy
    has_many :fights, through: :bunny_fight_stats

    validates :name,
              presence: true,
              length: { minimum: 0, maximum: 50 },
              uniqueness: true
  end
end
