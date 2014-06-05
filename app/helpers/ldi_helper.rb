module LdiHelper
  def elasticsearch_poblacion(poblacion)
    client = Elasticsearch::Client.new

    client.search :index => ENV['dbname'], :type => "poblacion", :body =>
        {
            :query => {
                :match => {
                    :nombre => poblacion
                }
            }
        }
  end

  def reemplazar_nombre_poblacion_por_modelo(ldi, res)
    if res["hits"]["total"] > 0
      ldi[:poblacion] = Poblacion.where("nombre = ?", res["hits"]["hits"][0]["_source"]["nombre"]).first
    else
      ldi[:poblacion] = Poblacion.new
    end
  end
end
