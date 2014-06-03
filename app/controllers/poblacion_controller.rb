class PoblacionController < ApplicationController
  def show
    @poblacion = Poblacion.find(params[:id])
    @ldis = @poblacion.ldis.page(params[:page]).per(5)
  end
end
