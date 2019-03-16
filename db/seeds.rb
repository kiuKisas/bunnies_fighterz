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
      attack: 5,
      defense: 6,
      stamina: 3,
      luck: 1
    }
  },
  {
    name: 'Anastasia',
    bunny_stat_attributes: {
      life: 2,
      attack: 3,
      defense: 4,
      stamina: 4,
      luck: 7
    }
  },
  {
    name: 'Joachim',
    bunny_stat_attributes: {
      life: 5,
      attack: 2,
      defense: 6,
      stamina: 3,
      luck: 4
    }
  },
  {
    name: 'Julietas',
    bunny_stat_attributes: {
      life: 2,
      attack: 8,
      defense: 4,
      stamina: 2,
      luck: 4
    }
  },
  {
    name: 'LLamateur',
    bunny_stat_attributes: {
      life: 1,
      attack: 1,
      defense: 2,
      stamina: 8,
      luck: 8
    }
  },
  {
    name: 'Batman',
    bunny_stat_attributes: {
      life: 8,
      attack: 8,
      defense: 2,
      stamina: 1,
      luck: 1
    }
  }


]
Bunny.create(bunnies_list)
