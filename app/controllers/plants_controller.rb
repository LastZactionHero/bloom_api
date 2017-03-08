class PlantsController < ApplicationController
  def favorite
    @plant = Plant.find(params[:id])
    @plant.favorite = true
    @plant.save
    head 204
  end

  def unfavorite
    @plant = Plant.find(params[:id])
    @plant.favorite = false
    @plant.save
    head 204
  end
end
