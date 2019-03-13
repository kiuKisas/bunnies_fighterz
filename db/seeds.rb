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
      life: 100,
      attack: 100,
      defense: 100,
      stamina: 100,
      luck: 100
    }
  },
  {
    name: 'anastasia',
    bunny_stat_attributes: {
      life: 100,
      attack: 100,
      defense: 100,
      stamina: 100,
      luck: 100
    }
  }
]
Bunny.create(bunnies_list)
