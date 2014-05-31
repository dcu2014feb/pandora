module PoblacionHelper
  def calc_valoraciones id
    tmpVal = 0
    val = Valoracion.where("ldi_id = ?",id)

    # Suma las valoraciones
    val.each do |v|
      tmpVal += v[:puntuacion]
    end

    # Halla la media de las valoraciones si existen, -1 si no
    if val.length != 0
      tmpVal = tmpVal / val.length
    else
      -1
    end
  end
end
