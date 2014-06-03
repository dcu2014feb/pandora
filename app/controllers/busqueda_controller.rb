class BusquedaController < ApplicationController
  include BusquedaHelper

  def new
  end

  def index
    @resultado = elasticsearch_todo(params[:query])["hits"]["hits"]
  end
end
