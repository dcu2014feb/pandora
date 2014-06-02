class LdiController < ApplicationController
  before_action :ldi_params, :only => :create

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

    ldi[:poblacion] = Poblacion.where("nombre = ?", res["hits"]["hits"][0]["_source"]["nombre"]).first if res["hits"]["total"] > 0

    @ldi = Ldi.new(ldi)
    @ldi.usuario = current_usuario;
    @ldi.save!

    redirect_to :controller => 'comentario', :action => 'new', :id_ldi => @ldi.id
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def ldi_params
    params.require(:ldi).permit!
  end
end
