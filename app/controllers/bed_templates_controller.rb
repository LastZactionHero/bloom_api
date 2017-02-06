class BedTemplatesController < ApplicationController
  def index
    bed_templates = BedTemplate.all
    render status: 200, json: bed_templates.map{|b| BedTemplateSerializer.new(b).to_json }
  end

  def create
    bed_template = BedTemplate.create(config: params[:config])

    if bed_template.errors.any?
      render status: 400, json: { errors: bed_template.errors }
    else
      render status: 201, json: BedTemplateSerializer.new(bed_template).to_json
    end
  end

  def update
    bed_template = BedTemplate.find(params[:id])
    bed_template.update(config: params[:config])

    if bed_template.errors.any?
      render status: 400, json: { errors: bed_template.errors }
    else
      render status: 200, json: BedTemplateSerializer.new(bed_template).to_json
    end
  end

  def destroy
    bed_template = BedTemplate.find(params[:id])
    bed_template.destroy
    render nothing: true
  end

  def placements
    width = params[:width].to_i
    height = params[:height].to_i
    bed_template = BedTemplate.find(params[:id])
    placements = bed_template.render(params[:width].to_i, params[:height].to_i)
    render status: 200, json: {width: width, height: height, placements: placements}
  end
end