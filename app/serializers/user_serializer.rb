class UserSerializer < ActiveModel::Serializer
  attributes :email, :text

  def text
  	object.email
  end
end
