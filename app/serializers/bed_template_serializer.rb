class BedTemplateSerializer < BaseSerializer
  def to_json
    {
      id: @object.id,
      name: @object.name,
      config: @object.config
    }
  end
end