class HomeController < ApplicationController
  def scene
    @scene = params[:scene]
  end
end
