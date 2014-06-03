class LdiController < ApplicationController
  include ApplicationHelper
  include LdiHelper

  before_action :ldi_params, :only => [:create, :update]

  def new
    @ldi = Ldi.new
  end

  def create
    ldi = params[:ldi]                                # Obtener los parámetros del formulario
    res = elasticsearch_poblacion(ldi[:poblacion])    # Buscar la población del formulario en ES
    reemplazar_nombre_poblacion_por_modelo(ldi, res)

    # Crear y guardar el modelo de ldi
    @ldi = Ldi.new(ldi)
    @ldi.usuario = current_usuario;
    @ldi.save!

    # Fixme: Redirigir con ruta (no hardcodear)
    redirect_to :controller => '/comentario', :action => 'new', :id_ldi => @ldi.id
  end

  def edit
    @ldi = Ldi.find(params[:id])
  end

  def update
    ldi = params[:ldi]                                    # Modelo nuevo obtenido del formulario
    @ldi = Ldi.find(params[:id])                          # Modelo viejo obtenido de la BBDD

    if @ldi.poblacion.nombre != ldi[:poblacion][:nombre]           # Si se ha modificado la población en el formulario
      res = elasticsearch_poblacion(ldi[:poblacion][:nombre])      # Buscar la población del formulario en ES
      reemplazar_nombre_poblacion_por_modelo(ldi, res)
    else
      ldi[:poblacion] = @ldi.poblacion;                            # Reemplazar campos de población por el modelo entero
    end

    @ldi.update!(ldi)                                     # Actualizar ldi viejo con los nuevos parámetros

    # Fixme: Redirigir con ruta (no hardcodear)
    redirect_to :controller => '/comentario', :action => 'new', :id_ldi => @ldi.id
  end

  def destroy
    # Eliminar ldi de la BBDD
    @ldi = Ldi.find(params[:id])
    @ldi.destroy!

    # Eliminar ldi de ES
    client = Elasticsearch::Client.new
    client.delete :index => "walko", :type => "ldi", :id => params[:id]

    redirect_to :root
  end

  private

  def ldi_params
    #Fixme: Evitar pasar todos los parámetros
    params.require(:ldi).permit!
  end
end
