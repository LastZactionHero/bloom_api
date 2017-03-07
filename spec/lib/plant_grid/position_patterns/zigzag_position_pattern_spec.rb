require 'rails_helper'

module PlantGrid
  module PositionPatterns
    describe SingleRowPositionPattern do
      describe 'position' do
        it 'positions plants' do
          test_cases = [
            {grid: {width: 72, height: 36}, plant: {width: 24, horizontal_spacing: 0, vertical_spacing: 0}, expected: [[12,12], [36,24], [60,12]]}, # Three plants, no extra space
          ]
          test_cases.each do |test_case|
            grid = (1..test_case[:grid][:height]).map{ Array.new(test_case[:grid][:width], ' ') }
            plant = PlantTemplate.new('A',
                                      test_case[:plant][:width],
                                      test_case[:plant][:horizontal_spacing],
                                      test_case[:plant][:vertical_spacing],
                                      {},
                                      'tooltip',
                                      'plant type')
            ZigZagPositionPattern.new(grid, test_case[:grid][:width], test_case[:grid][:height], plant).position

            # Make sure total number of plants matches expected
            expect(grid.flat_map{|row| row.select{|c| c.is_a?(PlantTemplate)}}.length).to eq(test_case[:expected].length)

            # Make sure the plants are in the right place
            test_case[:expected].each do |expected_position|
              unless grid[expected_position[1]][expected_position[0]].is_a?(PlantTemplate)
                puts expected_position.join(',')
              end
              expect(grid[expected_position[1]][expected_position[0]].is_a?(PlantTemplate)).to be_truthy
            end
          end
        end
      end
    end
  end
end