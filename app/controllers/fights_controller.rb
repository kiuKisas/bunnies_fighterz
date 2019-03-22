# frozen_string_literal: true

class FightsController < ApplicationController
  expose :bunnies, -> { Bunny.all }
  expose :fights, -> { Fight.all }
  expose :weapons, -> { Weapon.all }
  expose :fight
  expose :bunny_fight_stats, -> { fight.bunny_fight_stats }

  def index; end

  def show; end

  def new; end

  def create
    byebug
    fight = fight_launcher
    if fight&.save
      redirect_to fight_path(fight)
    else
      render :new
    end
  end

  def destroy
    fight.destroy
    redirect_to fights_path
  end

  private

  def fight_params
    return [] unless params[:fight].present?

    params.require(:fight).permit(
      bunny_fight_stats_attributes: [%i[bunny_id weapon_id]]
    )
  end

  def fight_launcher
    fight = Fight.create(fight_params)
    return fight if fight.invalid?

    fight_service = FightService.new(fight)
    fight_service.call
  end
end
