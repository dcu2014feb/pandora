class LdiController < ApplicationController
  include ApplicationHelper
  include LdiHelper

  before_action :ldi_params, :only => [:create, :update]
  before_action :authenticate_usuario!
  before_action :encontrar_ldi, :only => [:edit, :update, :destroy]
  before_action :verify_usuario, :only => [:edit, :update, :destroy]

  def new
    @ldi = Ldi.new
    @ldi.poblacion = Poblacion.new
  end

  def create
    ldi = params[:ldi]                                # Obtener los parámetros del formulario
    res = elasticsearch_poblacion(params[:poblacion][:nombre])    # Buscar la población del formulario en ES
    reemplazar_nombre_poblacion_por_modelo(ldi, res)

    agregar_geolocalizacion(ldi)

    # Crear y guardar el modelo de ldi
    @ldi = Ldi.new(ldi)
    @ldi.usuario = current_usuario

    if @ldi.save
      # Fixme: Redirigir con ruta (no hardcodear)
      redirect_to :controller => '/comentario', :action => 'new', :id_ldi => @ldi.id
    else
      render "/ldi/new"
    end
  end

  def edit
  end

  def update
    ldi = params[:ldi]                                    # Modelo nuevo obtenido del formulario

    if @ldi.poblacion.nombre != params[:poblacion][:nombre]           # Si se ha modificado la población en el formulario
      res = elasticsearch_poblacion(params[:poblacion][:nombre])      # Buscar la población del formulario en ES
      reemplazar_nombre_poblacion_por_modelo(ldi, res)
    else
      ldi[:poblacion] = @ldi.poblacion;                            # Reemplazar campos de población por el modelo entero
    end

    agregar_geolocalizacion(ldi)

    if @ldi.update(ldi)                                           # Actualizar ldi viejo con los nuevos parámetros
      # Fixme: Redirigir con ruta (no hardcodear)
      redirect_to :controller => '/comentario', :action => 'new', :id_ldi => @ldi.id
    else
      render :controller => "/ldi", :action => "edit", :id_ldi => @ldi.id
    end
  end

  def destroy
    # Eliminar ldi de la BBDD
    @ldi.destroy!

    # Eliminar ldi de ES
    client = Elasticsearch::Client.new
    client.delete :index => ENV['dbname'], :type => "ldi", :id => params[:id]

    redirect_to :root
  end

  private

  def encontrar_ldi
    @ldi = Ldi.find(params[:id])
  end

  def ldi_params
    #Fixme: Evitar pasar todos los parámetros
    params.require(:ldi).permit!
  end

  def verify_usuario
    if current_usuario != @ldi.usuario
      render :status => :forbidden, :text => "Prohibido"
    end
  end
end
