class BusquedaController < ApplicationController
  def new
  end

  def index
    client = Elasticsearch::Client.new

    resultado = client.search :index => "walko", :body =>
      {
        :query => {
          :multi_match => {
            :query => params[:query],
            :fields => ["nombre", "descripcion", "categoria"]
          }
        }
      }

    @resultado = resultado["hits"]["hits"]

  end
end
