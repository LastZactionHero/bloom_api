# # Modern/Linear A
# # cell_a = PlantGridCell.new(1.0, 0.6, Plant.new('A', 3, 2, 2), RectPositionPattern)
# # cell_b = PlantGridCell.new(1.0, 0.4, Plant.new('B', 2, 1, 1), RectPositionPattern)
# # cell_composite = CompositeGridCell.new(1.0, 1.0, :vertical, [cell_a, cell_b])
# 
# # Modern/Linear B
# # cell_a = PlantGridCell.new(0.3, 1.0, Plant.new('A', 2, 6, 2), RectPositionPattern)
# # cell_b = PlantGridCell.new(0.4, 1.0, Plant.new('B', 3, 12, 3), RectPositionPattern)
# # cell_c = PlantGridCell.new(0.3, 1.0, Plant.new('A', 2, 6, 2), RectPositionPattern)
# # cell_composite = CompositeGridCell.new(1.0, 1.0, :horizontal, [cell_a, cell_b, cell_c])
# 
# json = File.read('./template_definitions/modern_linear_c.json')
# template = BedTemplate.parse(JSON.parse(json))
# 
# # With a minimum height
# # cell_a = PlantGridCell.new(1.0, 0.6, Plant.new('A', 3, 2, 2), RectPositionPattern)
# # cell_b = PlantGridCell.new(1.0, 0.4, Plant.new('B', 2, 1, 1), RectPositionPattern, {min_height: 10})
# # cell_composite = CompositeGridCell.new(1.0, 1.0, :vertical, [cell_a, cell_b])
# 
# # With a minimum width
# # cell_a = PlantGridCell.new(0.3, 1.0, Plant.new('A', 2, 6, 2), RectPositionPattern, {min_width: 24})
# # cell_b = PlantGridCell.new(0.4, 1.0, Plant.new('B', 3, 12, 3), RectPositionPattern)
# # cell_c = PlantGridCell.new(0.3, 1.0, Plant.new('A', 2, 6, 2), RectPositionPattern)
# # cell_composite = CompositeGridCell.new(1.0, 1.0, :horizontal, [cell_a, cell_b, cell_c])
