class BedTemplateSerializer < BaseSerializer
  def to_json
    {
      id: @object.id,
      name: @object.name,
      config: @object.config,
      design_size: @object.design_size,
      template_plants: @object.template_plants
    }
  end
end