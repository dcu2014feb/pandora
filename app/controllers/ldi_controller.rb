class LdiController < ApplicationController
  def new
  end

  def create
  end

  def show
    @ldi = Ldi.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
