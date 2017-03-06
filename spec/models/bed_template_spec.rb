require 'rails_helper'

RSpec.describe BedTemplate, type: :model do

  describe 'render' do
    let(:bed_template) { FactoryGirl.create(:bed_template) }

    it 'draws a PlantGrid based on the bed template' do
      placements = bed_template.render(360, 72)
      expect(placements.length).to be > 0
    end

    it 'replaces template plants with Plants based on mapping' do
      # Pick a template_plant in the placements to replace
      placements = bed_template.render(360, 72)
      label = placements[0][:plant].label
      original_width = placements[0][:plant].width

      # Create a plant with a larger width
      plant = FactoryGirl.create(:plant, avg_width: original_width + 10, permalink: 'shrubby')

      # Create a mapping of label => plant, and re-render
      mapping = {label => plant}
      mapped_placements = bed_template.render(360, 72, mapping)

      # The replaced plant must show the new width
      replaced_placements = mapped_placements.select{|mp| mp[:plant].label == label}
      replaced_placements.each do |placement|
        expect(placement[:plant].width).to equal(plant.avg_width)
      end
    end
  end

end
