class BedTemplatesController < ApplicationController
  TEMPLATE_DEPTH_MINIMUM = 3 * 12
  TEMPLATE_DEPTH_MAXIMUM = 100 * 12
  TEMPLATE_WIDTH_MINIMUM = 3 * 12
  TEMPLATE_WIDTH_MAXIMUM = 100 * 12
  TEMPLATE_RESULT_LIMIT = 10

  def index
    bed_templates = BedTemplate.all.order("name ASC")
    render status: 200, json: bed_templates.map{|b| BedTemplateSerializer.new(b).to_json }
  end

  def suggestions
    width = params[:width].to_i * 12
    depth = params[:depth].to_i * 12

    errors = {}
    errors[:width] = ['is too small'] if width < TEMPLATE_WIDTH_MINIMUM
    errors[:depth] = ['is too small'] if depth < TEMPLATE_DEPTH_MINIMUM
    errors[:width] = ['is too large'] if width > TEMPLATE_WIDTH_MAXIMUM
    errors[:depth] = ['is too large'] if depth > TEMPLATE_DEPTH_MAXIMUM

    if errors.blank?
      # Sort to show nearest sizes
      bed_templates = BedTemplate.all.sort do |a,b|
        dist_a = ((width - a.design_size['width']) ** 2 + (depth - a.design_size['height']) ** 2) ** 0.5
        dist_b = ((width - b.design_size['width']) ** 2 + (depth - b.design_size['height']) ** 2) ** 0.5

        dist_a <=> dist_b
      end.first(TEMPLATE_RESULT_LIMIT)

      render status: 200, json: bed_templates.map{|b| BedTemplateSerializer.new(b).to_json }
    else
      render status: 400, json: { errors: errors }
    end
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
    head 200
  end

  def placements
    width = params[:width].to_i
    height = params[:height].to_i
    bed_template = BedTemplate.find(params[:id])

    # Set up the plant mapping, if available, replacing permalink with the Plant record
    # "template_plant_mapping"=>{"V"=>"bloomerang_dark_purple_lilac", "KF"=>"overdam_feather_reed_grass"}
    plant_mapping = params[:template_plant_mapping]
    if plant_mapping
      plant_mapping = plant_mapping.to_hash
      plant_mapping.each do |label, permalink|
        plant_mapping[label] = Plant.find_by(permalink: permalink)
      end
    end

    placements = bed_template.render(params[:width].to_i,
                                     params[:height].to_i,
                                     plant_mapping)
    render status: 200, json: {width: width, height: height, placements: placements}
  end

end
