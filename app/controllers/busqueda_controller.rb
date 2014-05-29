class BusquedaController < ApplicationController
  def new
  end

  def index
    @ldis = Ldi.where("nombre = ?", params[:query])
    @poblacions = Poblacion.where("nombre = ?", params[:query])
  end
end
