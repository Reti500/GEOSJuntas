class ComentarioSerializer < ActiveModel::Serializer
  attributes :titulo

  has_one :user, embed: :objects
end
