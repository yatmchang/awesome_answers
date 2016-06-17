class WinnerController < ApplicationController
  def index
  end

  def randomize
    array = params[:randomize].split(",").shuffle
    @winner = array[0]
    render :index
  end
end
