# frozen_string_literal: true

class FightService
  def initialize(fight)
    @fight = fight
    stats = build_stats
    @bunny_one = build_fighter(@fight.bunny_fight_stats.first, stats[:one], stats[:two])
    @bunny_two = build_fighter(@fight.bunny_fight_stats.last, stats[:two], stats[:one])
  end

  def call
    fighters = stamina_test(@bunny_one, @bunny_two)
    fight_stats = fight(fighters[:fighter], fighters[:target])
    fight_stats.each do |fight_stat|
      fight_stat.victory?
      fight_stat[:life] = 0 if fight_stat[:life].negative?
    end
    @fight
  end

  private

  def build_stats
    bunny_fight_stat_first = @fight.bunny_fight_stats.first
    bunny_fight_stat_last = @fight.bunny_fight_stats.last
    {
      one: concat_stat(
        bunny_fight_stat_first.bunny,
        bunny_fight_stat_first.weapons
      ),
      two: concat_stat(
        bunny_fight_stat_last.bunny,
        bunny_fight_stat_last.weapons
      )
    }
  end

  def concat_stat(stat_one, stat_two)
    return stat_one.bunny_stat unless stat_two.length.positive?

    weapon_stat_map = stat_two.first.weapon_stat.to_map
    bunny_stat_map = stat_one.bunny_stat.to_map
    bunny_stat_map.merge(weapon_stat_map) do |_key, val_one, val_two|
      val_one + val_two
    end
  end

  def build_fighter(bunny_fight_stat, stat_one, stat_two)
    attrs = build_fight_stat_attrs(stat_one, stat_two)
    bunny_fight_stat.update(attrs)
    {
      stat: stat_one,
      fight_stat: bunny_fight_stat
    }
  end

  def build_fight_stat_attrs(stat_one, stat_two)
    life = calc_life(stat_one[:life], BunnyFightStat::LIFE_MAX)
    {
      victory: false,
      life: life,
      life_total: life,
      damage: calc_damage(stat_one[:attack], stat_two[:defense]),
      damage_total: stat_one[:attack],
      attack: 0,
      attack_total: 0
    }
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
    fighter[:fight_stat].attack_total += 1
    return unless luck_test(fighter[:stat][:luck])

    damage = fighter[:fight_stat].damage
    target[:fight_stat][:life] -= damage
    fighter[:fight_stat].attack += 1
  end
end
