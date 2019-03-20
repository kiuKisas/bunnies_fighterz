# frozen_string_literal: true

class BunniesController < ApplicationController
  expose :bunnies, -> { Bunny.all }
  expose :bunny
  expose :bunny_stat, -> { bunny.bunny_stat }
  expose :stock_max, -> { BunnyStat::MAX_STOCK }
  expose :attr_value_max, -> { BunnyStat::MAX_VALUE }
  expose :attr_value_min, -> { BunnyStat::MIN_VALUE }

  def index; end

  def show; end

  def new
    bunny.build_bunny_stat
  end

  def edit; end

  def create
    if bunny.save
      redirect_to bunny_path(bunny)
    else
      render :new
    end
  end

  def update
    if bunny.update(bunny_params)
      redirect_to bunnies_path
    else
      render :edit
    end
  end

  def destroy
    bunny.fights.each(&:destroy)
    bunny.destroy
    redirect_to bunnies_path
  end

  private

  def bunny_params
    params.require(:bunny).permit(
      :name,
      bunny_stat_attributes: %i[life attack defense stamina luck]
    )
  end
end
