# frozen_string_literal: true

class FightService
  def initialize(bunny_one, bunny_two)
    @bunny_one = build_fighter(bunny_one, bunny_two)
    @bunny_two = build_fighter(bunny_two, bunny_one)
  end

  def call
    fighters = stamina_test(@bunny_one, @bunny_two)
    fight_stats = fight(fighters[:fighter], fighters[:target])
    fight_stats.each do |fighter|
      fighter.life = 0 if fighter.life.negative?
    end
    Fight.new(bunny_fight_stats: fight_stats)
  end

  private

  def build_fighter(bunny, defensive_bunny)
    defense = defensive_bunny.bunny_stat[:defense]
    {
      stat: bunny&.bunny_stat,
      fight_stat: bunny_fight_stat(
        bunny,
        calc_damage(bunny.bunny_stat[:attack], defense)
      )
    }
  end

  def bunny_fight_stat(bunny, damage)
    life = calc_life(bunny.bunny_stat.life, BunnyFightStat::LIFE_MAX)
    BunnyFightStat.new(
      bunny: bunny,
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
    if bunny_two[:stat].stamina > bunny_one[:stat].stamina
      { fighter: bunny_two, target: bunny_one }
    else
      { fighter: bunny_one, target: bunny_two }
    end
  end

  def luck_test(luck)
    luck >= rand(1..9)
  end

  def fight(fighter, target)
    if fighter[:fight_stat].life.positive? &&
       target[:fight_stat].life.positive?
      attack(fighter, target)
      fight(target, fighter)
    else
      [target[:fight_stat], fighter[:fight_stat]]
    end
  end

  def attack(fighter, target)
    fighter[:fight_stat].total_attack += 1
    return unless luck_test(fighter[:stat].luck)

    damage = fighter[:fight_stat].damage
    target[:fight_stat].life -= damage
    fighter[:fight_stat].succeed_attack += 1
  end
end
