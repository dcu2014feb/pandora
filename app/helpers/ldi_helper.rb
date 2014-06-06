require 'google_places'
require 'open-uri'

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

  def agregar_geolocalizacion(ldi)
    if ldi[:poblacion][:id] != nil      # Si tiene asociada una ciudad
      client = GooglePlaces::Client.new ENV['places_key']

      res = client.spots(ldi[:poblacion][:lat], ldi[:poblacion][:long], :radius => 10000,
                         :name => "#{ldi[:nombre]} + #{ldi[:direccion]}", :language => 'es')

      if res.count > 0
        ldi[:lat] = res[0][:lat]
        ldi[:long] = res[0][:lng]
        ldi[:direccion] = res[0][:formatted_address] if(ldi[:direccion] == nil || ldi[:direccion].empty?)
        ldi[:cod_postal] = res[0][:postal_code] if(ldi[:cod_postal] == nil || ldi[:cod_postal].empty?)

        if (ldi[:image] == nil && res[0][:photos].count > 0)
          image_url = res[0].photos[0].fetch_url(800)
          ldi[:image] = open(image_url)
        end
      end
    end
  end
end

