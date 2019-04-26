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
    fight = fight_launcher
    if fight.save
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
      bunny_fight_stats_attributes: [%i[bunny_id weapon_ids]]
    )
  end

  def fight_launcher
    return Fight.new unless params[:fight].present?

    fight = Fight.new(fight_params)
    return fight unless validate_fight

    fight_service = FightService.new(fight)
    fight_service.call
  end

  def validate_fight
    return false unless bunny_fight_stats.length == 2 &&
                        validate_uniq_bunnies

    bunny_fight_stats.each do |bunny_fight_stat|
      bunny_fight_stat.context = :init
      return false unless bunny_fight_stat.valid?

      bunny_fight_stat.context = nil
    end
    true
  end

  def validate_uniq_bunnies
    id_one = bunny_fight_stats.first.bunny.id
    id_two = bunny_fight_stats.last.bunny.id

    id_one != id_two
  end
end
