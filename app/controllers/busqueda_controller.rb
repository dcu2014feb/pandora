class BusquedaController < ApplicationController
  include BusquedaHelper

  def new
  end

  def index
    @resultados = Kaminari.paginate_array(elasticsearch_todo(params[:query])["hits"]["hits"]).page(params[:page])
  end
end
