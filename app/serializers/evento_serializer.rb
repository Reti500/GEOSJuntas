class EventoSerializer < ActiveModel::Serializer
  attributes :id, :titulo, :descripcion, :mes, :dia, :hora

  def mes
  	(object.fecha && object.fecha.strftime("%b")) || nil
  end

  def dia
  	(object.fecha && object.fecha.strftime("%d")) || nil
  end

  def hora
  	(object.fecha && object.fecha.strftime("%H:%M hrs"))
  end
end
