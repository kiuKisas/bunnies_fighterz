# frozen_string_literal: true

class Weapon < ApplicationRecord
  include FightObjectConcern
  has_one :weapon_stat, dependent: :destroy
  has_and_belongs_to_many :bunny_fight_stats, optional: true

  accepts_nested_attributes_for :weapon_stat
  validates_associated :weapon_stat
end
