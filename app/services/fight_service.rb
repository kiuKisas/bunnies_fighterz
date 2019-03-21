# frozen_string_literal: true

class FightService
  def initialize(bunny_one, bunny_two, weapon_one, weapon_two)
    stat_one = build_bunny_final_stat(bunny_one, weapon_one)
    stat_two = build_bunny_final_stat(bunny_two, weapon_two)
    @bunny_one = build_fighter(bunny_one, weapon_one, stat_one, stat_two)
    @bunny_two = build_fighter(bunny_two, weapon_two, stat_two, stat_one)
  end

  def call
    fighters = stamina_test(@bunny_one, @bunny_two)
    fight_stats = fight(fighters[:fighter], fighters[:target])
    fight_stats.each do |fighter|
      fighter[:life] = 0 if fighter[:life].negative?
    end
    Fight.new(bunny_fight_stats: fight_stats)
  end

  private

  def build_bunny_final_stat(bunny, weapon)
    return bunny.bunny_stat unless weapon
    weapon_stat_map = weapon.weapon_stat.to_map
    bunny_stat_map = bunny.bunny_stat.to_map
    bunny_stat_map.merge(weapon_stat_map) do |_key, bunny_val, weapon_val|
      bunny_val + weapon_val
    end
  end

  def build_fighter(bunny, weapon, stat_one, stat_two)
    life = calc_life(stat_one[:life], BunnyFightStat::LIFE_MAX)
    damage = calc_damage(stat_one[:attack], stat_two[:defense])

    {
      stat: stat_one,
      fight_stat: build_bunny_fight_stat(bunny, life, damage, weapon)
    }
  end

  def build_bunny_fight_stat(bunny, life, damage, weapon)
    BunnyFightStat.new(
      bunny: bunny,
      weapons: weapon ? [weapon] : [],
      victory: false,
      life: life,
      life_total: life,
      total_attack: 0,
      succeed_attack: 0,
      damage: damage
    )
  end

  def calc_life(life_stat, life_max)
    (life_stat * life_max).divmod(10).first
  end

  def calc_damage(attack, defense)
    # change divmod(10) if max point > 10
    defensive_result = (attack * defense).divmod(10)
    defensive_point = defensive_result.first +
                      (defensive_result.last > 5 ? 1 : 0)
    damage = attack - defensive_point
    damage.positive? ? damage : 1
  end


  def stamina_test(bunny_one, bunny_two)
    if bunny_two[:stat][:stamina] > bunny_one[:stat][:stamina]
      { fighter: bunny_two, target: bunny_one }
    else
      { fighter: bunny_one, target: bunny_two }
    end
  end

  def luck_test(luck)
    luck >= rand(1..9)
  end

  def fight(fighter, target)
    if fighter[:fight_stat][:life].positive? &&
       target[:fight_stat][:life].positive?
      attack(fighter, target)
      fight(target, fighter)
    else
      [target[:fight_stat], fighter[:fight_stat]]
    end
  end

  def attack(fighter, target)
    fighter[:fight_stat].total_attack += 1
    return unless luck_test(fighter[:stat][:luck])

    damage = fighter[:fight_stat].damage
    target[:fight_stat][:life] -= damage
    fighter[:fight_stat].succeed_attack += 1
  end
end
