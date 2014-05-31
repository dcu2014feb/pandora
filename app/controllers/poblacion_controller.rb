class PoblacionController < ApplicationController
  def new
  end

  def create
  end

  def show
    @poblacion = Poblacion.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
