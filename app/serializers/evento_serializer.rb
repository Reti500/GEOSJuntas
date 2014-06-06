class EventoSerializer < ActiveModel::Serializer

  attributes :id, :titulo, :descripcion, :mes, :dia, :hora
  has_many :users, embed: :objects
  has_many :comentarios, embed: :objects

  def mes
  	(object.fecha && object.fecha.strftime("%b")) || nil
  end

  def dia
  	(object.fecha && object.fecha.strftime("%d")) || nil
  end

  def hora
  	(object.hora && object.hora.strftime("%H:%M hrs")) || nil
  end
end
