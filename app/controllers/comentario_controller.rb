class ComentarioController < ApplicationController
  #before_action :comentario_params, :only => :update

  def new
    @ldi = Ldi.find(params[:id_ldi])
  end

  def create
    @comentario = Comentario.new
    @comentario.texto = params[:comentario]
    @comentario.ldi = Ldi.find(params[:id_ldi])

    if usuario_signed_in?
      @comentario.usuario = current_usuario
    end
    @comentario.save!

    redirect_to :back
  end

  def edit
    @comentario = Comentario.find(params[:id_com])
    @ldi = Ldi.find(params[:id_ldi])
  end

  def update
    @comentario = Comentario.find(params[:id_com])
    @comentario.texto = params[:texto]
    @comentario.save!

    redirect_to :controller => "/comentario", :action => "new", :id_ldi => params[:id_ldi]
  end

  def destroy
    @comentario = Comentario.find(params[:id_com])
    @comentario.destroy!

    redirect_to :controller => "/comentario", :action => "new", :id_ldi => params[:id_ldi]
  end

  private

  def comentario_params
    params.require(:comentario).permit!
  end
end
