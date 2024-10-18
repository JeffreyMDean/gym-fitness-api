class PokemonsController < ApplicationController
  def show
    response = HTTParty.get("https://pokeapi.co/api/v2")
    if response.success?
      render json: { 
                    ability: response["ability"], 
                    item: response["item"]
                    }
    else
      render json: { error: "Pokemon not found" }, status: 404 
    end
    # fetch the uri
    # error handling
    # if success then render pokemon name, otherwise render json error
  end
end 