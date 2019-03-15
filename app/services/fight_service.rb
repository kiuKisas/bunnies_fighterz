# frozen_string_literal: true

class FightService
  def initialize(bunny_one, bunny_two)
    @bunny_one = build_fighter(bunny_one, bunny_two) if bunny_one&.bunny_stat
    @bunny_two = build_fighter(bunny_two, bunny_one) if bunny_two&.bunny_stat
  end

  def call
    return Fight.new unless @bunny_one && @bunny_two

    fighters = stamina_test(@bunny_one, @bunny_two)
    fight_stats = fight(fighters[:fighter], fighters[:target])
    fight_stats.each do |fighter|
      victory?(fighter)
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

  def calc_damage(attack, defense)
    # divmod(1000) to get a value between 1 and 10
    pts_defense = (attack * defense).divmod(1000).first
    return 1 unless pts_defense < attack

    attack - pts_defense
  end

  def bunny_fight_stat(bunny, damage)
    BunnyFightStat.new(
      bunny: bunny,
      victory: false,
      life: bunny.bunny_stat.life,
      total_attack: 0,
      succeed_attack: 0,
      damage: damage
    )
  end

  def stamina_test(bunny_one, bunny_two)
    if bunny_two[:stat].stamina > bunny_one[:stat].stamina
      { fighter: bunny_two, target: bunny_one }
    else
      { fighter: bunny_one, target: bunny_two }
    end
  end

  def luck_test(luck)
    luck <= rand(1..9)
  end

  def victory?(fight_stat)
    fight_stat.life.positive?
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
