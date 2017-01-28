class GenericNameSerializer < BaseSerializer
  def to_json
    {
      id: @object.id,
      name: @object.name
    }
  end
end