class HomesController < ApplicationController

  def top
    @weathers = City.all
  end
  
end
