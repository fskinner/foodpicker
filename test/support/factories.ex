defmodule Foodpicker.Factory do
  use ExMachina.Ecto, repo: Foodpicker.Repo

  def category_factory do
    %Foodpicker.Picker.Category{
      name: "some food"
    }
  end

  def restaurant_factory do
    %Foodpicker.Picker.Restaurant{
      name: "random restaurant",
      category_list: "new category"
    }
  end
end
