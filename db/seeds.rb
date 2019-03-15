# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bunnies_list = [
  {
    name: 'poker',
    bunny_stat_attributes: {
      life: 5,
      attack: 5,
      defense: 3,
      stamina: 1,
      luck: 1
    }
  },
  {
    name: 'anastasia',
    bunny_stat_attributes: {
      life: 2,
      attack: 2,
      defense: 4,
      stamina: 2,
      luck: 5
    }
  }
]
Bunny.create(bunnies_list)
