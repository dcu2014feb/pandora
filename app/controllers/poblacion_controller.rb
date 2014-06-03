class PoblacionController < ApplicationController
  def show
    @poblacion = Poblacion.find(params[:id])
  end
end
