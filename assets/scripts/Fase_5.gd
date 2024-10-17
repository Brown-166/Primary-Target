extends Node2D



func _ready():
	Global.fase = "Fase_5"
	print(get_tree())



func _physics_process(delta):
	for area in $Layers/distance_0.get_overlapping_areas():
		var vehicle = area.get_parent()
		vehicle.scale.x = 2
		vehicle.scale.y = 2
	for area in $Layers/distance_1.get_overlapping_areas():
		var vehicle = area.get_parent()
		vehicle.scale.x = 1.45
		vehicle.scale.y = 1.45
	for area in $Layers/distance_2.get_overlapping_areas():
		var vehicle = area.get_parent()
		vehicle.scale.x = 1.05
		vehicle.scale.y = 1.05
	for area in $Layers/distance_3.get_overlapping_areas():
		var vehicle = area.get_parent()
		vehicle.scale.x = 0.8
		vehicle.scale.y = 0.8
	for area in $Layers/distance_4.get_overlapping_areas():
		var vehicle = area.get_parent()
		vehicle.scale.x = 0.5
		vehicle.scale.y = 0.5
	for area in $Layers/distance_5.get_overlapping_areas():
		var vehicle = area.get_parent()
		vehicle.scale.x = 0.5
		vehicle.scale.y = 0.5
