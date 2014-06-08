class ValoracionController < ApplicationController

  before_action :authenticate_usuario!

  def get
    Valoracion.where("ldi_id = ? AND usuario_id = ?", params[:id_ldi], current_usuario.id).first
  end

  def send attr
    v = Valoracion.where("ldi_id = ? AND usuario_id = ?", params[:ldi_id], current_usuario.id).first
    if v.nil?
      v = Valoracion.new :ldi_id => params[:ldi_id], :usuario_id => current_usuario.id, :puntuacion => params[:score]
      v.save!
    else
      v.update! :puntuacion => params[:score]
    end
  end
end
