# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
Foodpicker.Picker.create_restaurant(%{
  "name" => "JM Sushi",
  "category_list" => "Japa, Japones, Sushi"
})

#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
