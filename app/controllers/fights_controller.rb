# frozen_string_literal: true

class FightsController < ApplicationController

  expose :bunnies, -> { Bunny.all }
  expose :fights, -> { Fight.all }
  expose :fight

  def index; end

  def show; end

  def new; end

  def create
    # refacto
    # redo, array, check if two
    fight = helpers.launch_fight(
      Bunny.find(),
      Bunny.find(fight_params[:bunny_two_id])
    )
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
    params.require(:fight).permit(
      %i[bunny_one_id bunny_two_id]
    )
  end

end
