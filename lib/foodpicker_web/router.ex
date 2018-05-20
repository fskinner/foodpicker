defmodule FoodpickerWeb.Router do
  use FoodpickerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", FoodpickerWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)

    resources("/categories", CategoryController)
    resources("/restaurants", RestaurantController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", FoodpickerWeb do
  #   pipe_through :api
  # end
end
