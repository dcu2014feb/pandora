module ApplicationHelper
  def calcular_valoraciones id
    tmpVal = 0
    vals = Valoracion.where("ldi_id = ?",id)

    # Suma la puntuación de las valoraciones
    vals.each do |v|
      tmpVal += v[:puntuacion]
    end

    # Devuelve la media de las valoraciones si existen, -1 si no
    if vals.length != 0
      tmpVal / vals.length
    else
      -1
    end
  end
end
