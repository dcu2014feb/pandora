class ComentarioController < ApplicationController
  before_action :encontrar_comentario, :only => [:edit, :update, :destroy]
  before_action :authenticate_usuario!, :only => [:edit, :update, :destroy]
  before_action :verify_usuario, :only => [:edit, :update, :destroy]

  def new
    @ldi = Ldi.find(params[:id_ldi])
    @comentarios = @ldi.comentarios.page(params[:page]).per(5)
  end

  def create
    @comentario = Comentario.new
    @comentario.texto = params[:texto]
    @comentario.ldi = Ldi.find(params[:id_ldi])

    if usuario_signed_in?
      @comentario.usuario = current_usuario
    end
    @comentario.save!

    redirect_to :controller => "/comentario", :action => "new", :id_ldi => params[:id_ldi]
  end

  def edit
    @ldi = Ldi.find(params[:id_ldi])
    @comentarios = @ldi.comentarios.page(params[:page]).per(5)
  end

  def update
    @comentario.texto = params[:texto]
    @comentario.save!

    redirect_to :controller => "/comentario", :action => "new", :id_ldi => params[:id_ldi]
  end

  def destroy
    @comentario.destroy!

    redirect_to :controller => "/comentario", :action => "new", :id_ldi => params[:id_ldi]
  end

  private

  def encontrar_comentario
    @comentario = Comentario.find(params[:id_com])
  end

  def verify_usuario
    if current_usuario != @comentario.usuario
      render :status => :forbidden, :text => "Prohibido"
    end
  end
end
