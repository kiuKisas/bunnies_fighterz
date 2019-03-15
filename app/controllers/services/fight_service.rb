# frozen_string_literal: true
class FightService
  def initialize(bunny_one, bunny_two)
    @fighters = if bunny_one&.bunny_stat && bunny_two&.bunny_stat
                  {
                    one: build_fighter(@bunny_one, @bunny_two[:defense]),
                    two: build_fighter(@bunny_two, @bunny_one[:defense])
                  }
                end
  end

  def call
    if @fighters.nil?
      Fight.new
    else
      @fighters = stamina_test(@fighters)
      @fighters = fight(@fighters)
      @fighters.map do |_key, fighter|
        fighter.fight_state = victory?(fighter.fight_state)
      end
      # build Fight
    end
  end

  private

  def build_fighter(bunny, defense)
    {
      stat: bunny&.bunny_stat,
      fight_stat: bunny_fight_stat(
        bunny,
        calc_damage(bunny[:attack], defense)
      )
    }
  end

  def calc_domage(attack, defense)
    # divmod(1000) to get a value between 1 and 10
    pts_defense = (attack * defense).divmod(1000)
    if pourc_defense < attack
      attack - pts_defense
    else
      1
    end
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

  def stamina_test(fighters)
    if fighters.two.stat.stamina > fighters.one.stat.stamina
      { attack: fighters.stat.two, defense: fighters.stat.one }
    else
      { attack: fighters.stat.one, defense: fighters.stat.two }
    end
  end

  def luck_test(luck)
    luck <= rand(1..9)
  end

  def victory?(fight_stat)
    if fight_stat.life.positive?
      fight_stat.victory = true
    elsif fight_stat.life.negative?
      fight_stat.life = 0
    end
    fight_stat
  end

  def fight(fighters)
    if fighters[:attack].fight_stat.life.positive? &&
       fighters[:defense].fight_stat.life.positive?
      fighters = attack(fighters)
      fight(attack: figthers[:defense], defense: fighters[:attack])
    else
      fighters
    end
  end

  def attack(figthers)
    fighter = figthers[:attack]
    fighter.fight_stat.total_attack += 1
    if luck_test(fighter.stat.luck)
      damage = fighter.fight_stat.domage
      fighter.fight_stat.life -= damage
      fighter.fight_stat.succeed_attack += 1
    end
    fighters[:attack] = fighter
    fighters
  end
end
