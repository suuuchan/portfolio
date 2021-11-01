class HomesController < ApplicationController

  def top
    @weathers = City.all
    # binding.irb
  end
  
end
