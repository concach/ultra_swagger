class RacesController < ApplicationController
  def index
    @races = Race.all.by_name_date
  end
  
  def show
    @race = Race.find(params[:id])
    @reviews = Review.where(race: @race, approved: true).by_item
  end
end