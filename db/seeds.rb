# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bunnies_list = [
  {
    name: 'Poker',
    bunny_stat_attributes: {
      life: 5,
      attack: 3,
      defense: 3,
      stamina: 3,
      luck: 1
    }
  },
  {
    name: 'Anastasia',
    bunny_stat_attributes: {
      life: 1,
      attack: 2,
      defense: 3,
      stamina: 2,
      luck: 7
    }
  },
  {
    name: 'Joachim',
    bunny_stat_attributes: {
      life: 4,
      attack: 1,
      defense: 5,
      stamina: 2,
      luck: 3
    }
  },
  {
    name: 'Julietas',
    bunny_stat_attributes: {
      life: 1,
      attack: 5,
      defense: 3,
      stamina: 1,
      luck: 3
    }
  },
  {
    name: 'Grumox',
    bunny_stat_attributes: {
      life: 1,
      attack: 1,
      defense: 2,
      stamina: 5,
      luck: 6
    }
  },
  {
    name: 'Batman',
    bunny_stat_attributes: {
      life: 6,
      attack: 6,
      defense: 1,
      stamina: 1,
      luck: 1
    }
  }


]

weapons_list = [
  {
    name: 'Excalibur !',
    weapon_stat_attributes: {
      life: 0,
      attack: 2,
      defense: 0,
      stamina: 0,
      luck: 2
    }
  },
  {
    name: 'Egide !',
    weapon_stat_attributes: {
      life: 1,
      attack: 0,
      defense: 2,
      stamina: 0,
      luck: 1
    }
  }
]

Bunny.create(bunnies_list)
Weapon.create(weapons_list)
