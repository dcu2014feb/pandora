class LdiController < ApplicationController
  before_action :ldi_params, :only => [:create, :update]

  def new
    @ldi = Ldi.new
  end

  def create
    ldi = params[:ldi]

    client = Elasticsearch::Client.new

    res = client.search :index => "walko", :type => "poblacion", :body =>
      {
        :query => {
          :match => {
            :nombre => ldi[:poblacion]
          }
        }
      }

    if res["hits"]["total"] > 0
      ldi[:poblacion] = Poblacion.where("nombre = ?", res["hits"]["hits"][0]["_source"]["nombre"]).first
    else
      ldi[:poblacion] = Poblacion.new
    end

    @ldi = Ldi.new(ldi)
    @ldi.usuario = current_usuario;
    @ldi.save!

    redirect_to :controller => 'comentario', :action => 'new', :id_ldi => @ldi.id
  end

  def edit
    @ldi = Ldi.find(params[:id])
  end

  def update
    client = Elasticsearch::Client.new

    @ldi = Ldi.find(params[:id])
    ldi = params[:ldi]

    if @ldi.poblacion.nombre != ldi[:poblacion][:nombre]
      res = client.search :index => "walko", :type => "poblacion", :body =>
          {
              :query => {
                  :match => {
                      :nombre => ldi[:poblacion][:nombre]
                  }
              }
          }

      if res["hits"]["total"] > 0
        ldi[:poblacion] = Poblacion.where("nombre = ?", res["hits"]["hits"][0]["_source"]["nombre"]).first
      else
        ldi[:poblacion] = Poblacion.new
      end
    else
      ldi[:poblacion] = @ldi.poblacion;
    end

    @ldi.update!(ldi)

    redirect_to :controller => '/comentario', :action => 'new', :id_ldi => @ldi.id
  end

  def destroy
    client = Elasticsearch::Client.new

    @ldi = Ldi.find(params[:id])
    @ldi.destroy!

    client.delete :index => "walko", :type => "ldi", :id => params[:id]

    redirect_to :root
  end

  private

  def ldi_params
    params.require(:ldi).permit!
  end
end
