# frozen_string_literal: true

class PagesController < ApplicationController
  expose :bunnies_length, -> { Bunny.all.length || 0}
  expose :fights_length, -> { Fight.all.length }
  expose :fight_ready, -> { bunnies_length >= 2 }

  def index; end
end
