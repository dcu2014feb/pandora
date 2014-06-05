class ComentarioController < ApplicationController
  before_action :params_comentario, :only => [:create, :update]
  before_action :encontrar_comentario, :only => [:edit, :update, :destroy]
  before_action :authenticate_usuario!, :only => [:edit, :update, :destroy]
  before_action :verify_usuario, :only => [:edit, :update, :destroy]

  def new
    @ldi = Ldi.find(params[:id_ldi])
    @comentarios = @ldi.comentarios.page(params[:page]).per(5)
    @comentario = Comentario.new
  end

  def create
    @ldi = Ldi.find(params[:id_ldi])
    @comentario = Comentario.new(params[:comentario])
    @comentario.ldi = @ldi

    if usuario_signed_in?
      @comentario.usuario = current_usuario
    end

    if @comentario.save
      redirect_to :controller => "/comentario", :action => "new", :id_ldi => params[:id_ldi]
    else
      @ldi = Ldi.find(params[:id_ldi])
      @comentarios = @ldi.comentarios.page(params[:page]).per(5)
      render :controller => "/comentario", :action => "new"
    end
  end

  def edit
    @ldi = Ldi.find(params[:id_ldi])
    @comentarios = @ldi.comentarios.page(params[:page]).per(5)
  end

  def update
    if @comentario.update params[:comentario]
      redirect_to :controller => "/comentario", :action => "new", :id_ldi => params[:id_ldi]
    else
      @ldi = Ldi.find(params[:id_ldi])
      @comentarios = @ldi.comentarios.page(params[:page]).per(5)
      render :controller => "/comentario", :action => "edit"
    end
  end

  def destroy
    @comentario.destroy!

    redirect_to :controller => "/comentario", :action => "new", :id_ldi => params[:id_ldi]
  end

  private

  def params_comentario
    params.require(:comentario).permit!
  end

  def encontrar_comentario
    @comentario = Comentario.find(params[:id_com])
  end

  def verify_usuario
    if current_usuario != @comentario.usuario
      render :status => :forbidden, :text => "Prohibido"
    end
  end
end
