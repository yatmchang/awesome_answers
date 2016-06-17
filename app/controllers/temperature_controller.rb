class TemperatureController < ApplicationController
  def index
  end

  def submit
    @temp_in_c = params[:temperature].to_i
    @temp_string =  @temp_in_c * 9 / 5 + 32
  end
end
