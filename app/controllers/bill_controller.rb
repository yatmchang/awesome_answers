class BillController < ApplicationController
  def index
  end

  def submit
    @amount  = params[:amount].to_f
    @tax     = params[:tax].to_f
    @tip     = params[:tips].to_f
    @number  = params[:number].to_i
    if @number > 0
      @portion = ((@amount + (@amount * @tax / 100) + (@tip * @amount / 100)) / @number)
      @text = "Each person pays $"
    else
      @text = "Please enter valid numbers"
      @portion = " "
    end
    render :index
  end
end
