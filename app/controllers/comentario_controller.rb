class ComentarioController < ApplicationController
  def new
    @ldi = Ldi.find(params[:id_ldi])
  end

  def create
    @comentario = Comentario.new
    @comentario.texto = params[:comentario]
    @comentario.ldi = Ldi.find(params[:id_ldi])

    #Fixme: Colocar el verdadero usuario.
    @comentario.usuario = Usuario.find(1)
    @comentario.save!

    redirect_to :back
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
