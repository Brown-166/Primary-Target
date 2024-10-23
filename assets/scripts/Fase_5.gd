extends Node2D

var C = ["242347", "b36b00", "8c1c1c", "042407", "f5f54c", "63b0a6", "dbdbdb", "4a4a4a", "0d0d0d"]
var color

var scaling = 0.05

func _sort_color():
	randomize()
	color = C[randi() % C.size()]

func _color_build(build):
	_sort_color()
	match build:
		0:
			$background/buildings/Right/building1/color.modulate = color
			_sort_color()
			$background/buildings/Right/building2/color.modulate = color
			_sort_color()
			$background/buildings/Right/building3/color.modulate = color
			_sort_color()
			$background/buildings/Right/building4/color.modulate = color
			_sort_color()
			$background/buildings/Left/building5/color.modulate = color
			_sort_color()
			$background/buildings/Left/building6/color.modulate = color
			_sort_color()
			$background/buildings/Left/building7/color.modulate = color
			_sort_color()
			$background/buildings/Left/building8/color.modulate = color
		1:
			$background/buildings/Right/building1/color.modulate = color
		2:
			$background/buildings/Right/building2/color.modulate = color
		3:
			$background/buildings/Right/building3/color.modulate = color
		4:
			$background/buildings/Right/building4/color.modulate = color
		5:
			$background/buildings/Left/building5/color.modulate = color
		6:
			$background/buildings/Left/building6/color.modulate = color
		7:
			$background/buildings/Left/building7/color.modulate = color
		8:
			$background/buildings/Left/building8/color.modulate = color



func _ready():
	Global.fase = "Fase_5"
	_color_build(0)
	$background/road.play("straight")
	$background/AnimationPlayerLeft.play("straight")
	$background/AnimationPlayerLeft.play("straight")



func _physics_process(delta):
	$background/road.speed_scale = $Player_motorcycle.foward/10
	$background/AnimationPlayerLeft.playback_speed = $Player_motorcycle.foward / 10
	$background/AnimationPlayerRight.playback_speed = $Player_motorcycle.foward / 10
	
	for area in $Layers/distance_0.get_overlapping_areas():
		var vehicle = area.get_parent()
		if vehicle.scale < Vector2(2, 2):
			vehicle.scale += Vector2(scaling, scaling)
	
	for area in $Layers/distance_1.get_overlapping_areas():
		var vehicle = area.get_parent()
		if vehicle.scale > Vector2(1.45, 1.45):
			vehicle.scale -= Vector2(scaling, scaling)
		elif vehicle.scale < Vector2(1.45, 1.45):
			vehicle.scale += Vector2(scaling, scaling)
	
	for area in $Layers/distance_2.get_overlapping_areas():
		var vehicle = area.get_parent()
		if vehicle.scale > Vector2(1.05, 1.05):
			vehicle.scale -= Vector2(scaling, scaling)
		elif vehicle.scale < Vector2(1.05, 1.05):
			vehicle.scale += Vector2(scaling, scaling)
	
	for area in $Layers/distance_3.get_overlapping_areas():
		var vehicle = area.get_parent()
		if vehicle.scale > Vector2(0.8, 0.8):
			vehicle.scale -= Vector2(scaling, scaling)
		elif vehicle.scale < Vector2(0.8, 0.8):
			vehicle.scale += Vector2(scaling, scaling)
	
	for area in $Layers/distance_4.get_overlapping_areas():
		var vehicle = area.get_parent()
		if vehicle.scale > Vector2(0.5, 0.5):
			vehicle.scale -= Vector2(scaling, scaling)
		elif vehicle.scale < Vector2(0.5, 0.5):
			vehicle.scale += Vector2(scaling, scaling)
	
	for area in $Layers/distance_5.get_overlapping_areas():
		var vehicle = area.get_parent()
		if vehicle.scale > Vector2(0.5, 0.5):
			vehicle.scale -= Vector2(scaling, scaling)
		elif vehicle.scale < Vector2(0.5, 0.5):
			vehicle.scale += Vector2(scaling, scaling)
	
	
	if $background/AnimationPlayerLeft.current_animation == "turn_right":
		$Player_motorcycle.position.x -= 5
	
	if Input.is_action_just_pressed("ui_right"):
		$background/road.play("turn_right")
		$background/AnimationPlayerLeft.play("turn_right")


func _on_AnimationPlayerLeft_animation_finished(anim_name):
	if anim_name == "turn_right":
		$background/road.play("straight")
		$background/AnimationPlayerLeft.play("straight")

