# frozen_string_literal: true

module FightHelper

  def launch_fight(player_one, player_two)
    #byebug
    #helpers.fight(
    #  player_one.bunny_stat,
    #  player_two.bunny_stat
    #)
    #attacker
    fight_stat_one = BunnyFightStat.new(
      bunny_id: player_one[:id]
    )
    fight_stat_two = BunnyFightStat.new(
      bunny_id: player_two[:id]
    )
    Fight.new(bunny_fight_stats: [
      fight_stat_one,
      fight_stat_two
    ])
  end
  private

  # stat_one will attack stat_two
  def attack(_stat_one, _stat_two)
  end
end
