# frozen_string_literal: true

class FightsController < ApplicationController
  expose :bunnies, -> { Bunny.all }
  expose :fights, -> { Fight.all }
  expose :fight
  expose :bunny_fight_stats, -> { fight.bunny_fight_stats }

  def index; end

  def show; end

  def new; end

  def create
    if fight_params &&
       fight_params[:bunny_one_id] &&
       fight_params[:bunny_two_id] &&
       (fight = fight_launcher)&.save
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
    return nil unless params[:fight].present?

    params.require(:fight).permit(
      %i[bunny_one_id bunny_two_id]
    )
  end

  def fight_launcher
    bunny_one = Bunny.find(fight_params[:bunny_one_id])
    bunny_two = Bunny.find(fight_params[:bunny_two_id])
    return Fight.new unless bunny_one&.bunny_stat && bunny_two&.bunny_stat

    fight_service = FightService.new(bunny_one, bunny_two)
    fight_service.call
  end
end
