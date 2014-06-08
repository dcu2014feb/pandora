class BusquedaController < ApplicationController
  include ApplicationHelper
  include BusquedaHelper

  def new
  end

  def index
    @resultados = elasticsearch_todo(params[:query])["hits"]["hits"]

    case params[:filtro]
      when "naturaleza"
        @resultados = @resultados.select do |el|
          el["_type"] == "ldi" && el["_source"]["categoria"] == "naturaleza"
        end

      when "restaurante"
        @resultados = @resultados.select do |el|
          el["_type"] == "ldi" && el["_source"]["categoria"] == "restaurante"
        end

      when "bar_pub"
        @resultados = @resultados.select do |el|
          el["_type"] == "ldi" && el["_source"]["categoria"] == "bar_pub"
        end

      when "alojamiento"
        @resultados = @resultados.select do |el|
          el["_type"] == "ldi" && el["_source"]["categoria"] == "alojamiento"
        end

      when "cultura"
        @resultados = @resultados.select do |el|
          el["_type"] == "ldi" && el["_source"]["categoria"] == "cultural"
        end

      when "poblacion"
        @resultados = @resultados.select do |el|
          el["_type"] == "poblacion"
        end
    end

    case params[:orden]
      when "fecha"
        sinfecha, confecha = @resultados.partition do |el|
          el["_source"]["created_at"].nil?
        end
        @resultados = []
        @resultados << sinfecha
        @resultados << confecha.sort_by do |el|
          el["_source"]["created_at"]
        end
        @resultados.flatten!

      when "nombre"
        @resultados = @resultados.sort_by do |el|
          el["_source"]["nombre"]
        end

      when "valoracion"
        sinvaloracion, convaloracion = @resultados.partition do |el|
          el["_type"] == "poblacion"
        end
        @resultados = []
        @resultados << convaloracion.sort_by{|el|
          calcular_valoraciones el["_source"]["id"]
        }.reverse
        @resultados << sinvaloracion
        @resultados.flatten!

      when "comentarios"
        sincomentarios, concomentarios = @resultados.partition do |el|
          el["_type"] == "poblacion"
        end
        @resultados = []
        @resultados << concomentarios.sort_by{|el|
          Comentario.where("ldi_id = ?", el["_source"]["id"]).count
        }.reverse
        @resultados << sincomentarios
        @resultados.flatten!
    end

    @resultados = Kaminari.paginate_array(@resultados).page(params[:page])
  end
end
