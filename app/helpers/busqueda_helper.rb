module BusquedaHelper
  def elasticsearch_todo(busqueda)
    client = Elasticsearch::Client.new
    client.search :index => "walko", :body =>
        {
            :query => {
                :multi_match => {
                    :query => busqueda,
                    :fields => ["nombre", "descripcion", "categoria"]
                }
            }
        }
  end
end
