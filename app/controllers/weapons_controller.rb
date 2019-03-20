# frozen_string_literal: true

class WeaponsController < ApplicationController
  expose :weapons, -> { Weapon.all }
  expose :weapon
  expose :weapon_stat, -> { weapon.weapon_stat }
  expose :stock_max, -> { WeaponStat::MAX_STOCK }
  expose :attr_value_max, -> { WeaponStat::MAX_VALUE }
  expose :attr_value_min, -> { WeaponStat::MIN_VALUE }

  def index; end

  def show; end

  def new
    weapon.build_weapon_stat
  end

  def edit; end

  def create
    if weapon.save
      redirect_to weapon_path(weapon)
    else
      render :new
    end
  end

  def update
    if weapon.update(weapon_params)
      redirect_to weapons_path
    else
      render :edit
    end
  end

  def destroy
    weapon.fights.each(&:destroy)
    weapon.destroy
    redirect_to weapons_path
  end

  private

  def weapon_params
    params.require(:weapon).permit(
      :name,
      weapon_stat_attributes: %i[life attack defense stamina luck]
    )
  end
end
