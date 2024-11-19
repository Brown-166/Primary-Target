extends Node2D

var C = ["242347", "b36b00", "8c1c1c", "042407", "f5f54c", "63b0a6", "dbdbdb", "4a4a4a", "0d0d0d"]
var color

var scaling = 0.05
var player_speed

onready var mini_player = $CanvasLayer/minimap/player
onready var mini_player_speed
var mini_player_dir = "up"

onready var mini_target = $CanvasLayer/minimap/target
var mini_target_speed = 0.1
var mini_target_dir = "up"
var tracking_target = true


const CAR = preload("res://assets/characters/Car_obstacle.tscn")
var CarP = [1, 2, 3]
var car_position
var CarT = [1, 2, 2, 2, 3, 3, 4]
var car_timer


var finish = false

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


func _scale_vehicles():
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


func _set_dir(new_dir, old_dir):
	if new_dir == "right":
		match old_dir:
			"up":
				old_dir = "right"
			"right":
				old_dir = "down"
			"down":
				old_dir = "left"
			"left":
				old_dir = "up"
	elif new_dir == "left":
		match old_dir:
			"up":
				old_dir = "left"
			"left":
				old_dir = "down"
			"down":
				old_dir = "right"
			"right":
				old_dir = "up"
	return old_dir



func _ready():
	Global.fase = "Fase_5"
	DB._save_new_game(DB.current_save)
	_color_build(0)
	$background/road.play("straight")
	$background/AnimationPlayerLeft.play("straight")
	$background/AnimationPlayerLeft.play("straight")
	randomize()
	car_timer = CarT[randi() % CarT.size()]
	$Timer_spawn_car.wait_time = car_timer
	$Timer_spawn_car.start()



func _physics_process(delta):
	if Global.dead == true:
		$AnimationPlayer.play("game_over")
	_scale_vehicles()
	player_speed = $Player_motorcycle.foward
	
	$background/road.speed_scale = player_speed / 10
	$background/AnimationPlayerLeft.playback_speed = player_speed / 10
	$background/AnimationPlayerRight.playback_speed = player_speed / 10
	
	
	
	if $background/AnimationPlayerLeft.current_animation == "turn_right":
		if player_speed == 100:
			$Player_motorcycle.position.x -= 6
		elif player_speed < 100 && player_speed >= 75:
			$Player_motorcycle.position.x -= 5
		elif player_speed < 75 && player_speed >= 50:
			$Player_motorcycle.position.x -= 4
		elif player_speed < 50 && player_speed >=25:
			$Player_motorcycle.position.x -= 3
		elif player_speed < 25 && player_speed > 0:
			$Player_motorcycle.position.x -= 2
	if $background/AnimationPlayerLeft.current_animation == "turn_left":
		if player_speed == 100:
			$Player_motorcycle.position.x += 6
		elif player_speed < 100 && player_speed >= 75:
			$Player_motorcycle.position.x += 5
		elif player_speed < 75 && player_speed >= 50:
			$Player_motorcycle.position.x += 4
		elif player_speed < 50 && player_speed >=25:
			$Player_motorcycle.position.x += 3
		elif player_speed < 25 && player_speed > 0:
			$Player_motorcycle.position.x += 2
	
	
	if finish == false:
		if player_speed == 100:
			mini_player_speed = 0.1
		elif player_speed < 100 && player_speed >= 75:
			mini_player_speed = 0.08
		elif player_speed < 75 && player_speed >= 50:
			mini_player_speed = 0.06
		elif player_speed < 50 && player_speed >=25:
			mini_player_speed = 0.04
		elif player_speed < 25 && player_speed > 0:
			mini_player_speed = 0.02
		else:
			mini_player_speed = 0
	else:
		mini_player_speed
	
	
	
	match mini_player_dir:
		"up":
			mini_player.position.y -= mini_player_speed
		"right":
			mini_player.position.x += mini_player_speed
		"down":
			mini_player.position.y += mini_player_speed
		"left":
			mini_player.position.x -= mini_player_speed
	
	match mini_target_dir:
		"up":
			mini_target.position.y -= mini_target_speed
		"right":
			mini_target.position.x += mini_target_speed
		"down":
			mini_target.position.y += mini_target_speed
		"left":
			mini_target.position.x -= mini_target_speed
	


func _on_AnimationPlayerLeft_animation_finished(anim_name):
	if anim_name == "turn_right" || anim_name == "turn_left":
		$background/road.play("straight")
		$background/AnimationPlayerLeft.play("straight")
		$background/AnimationPlayerRight.play("straight")



func _on_Area2D_side_walk_body_entered(body):
	if body.name == "Player_motorcycle":
		if player_speed == 100:
			Global.life -= 10
		elif player_speed < 100 && player_speed >= 50:
			Global.life -= 5
		
		$Player_motorcycle.foward = 40
		$Player_motorcycle._crash()
		if $Player_motorcycle.position.x > 640:
			$Player_motorcycle.global_position.x += 30
		else:
			$Player_motorcycle.global_position.x -= 30
		if Global.life <= 0:
			Global.dead = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "game_over":
		get_tree().change_scene("res://assets/interfaces/game_over.tscn")
	if anim_name == "loading_out":
		get_tree().change_scene("res://assets/cutscenes/cutscene_6.tscn")




func _on_sonar_animation_finished():
	$CanvasLayer/minimap/player/sonar.play("default")


func _on_Timer_sonar_timeout():
	$CanvasLayer/minimap/player/sonar.play("sonar")


func _on_Left_area_entered(area):
	if area.name == "mini_player":
		mini_player_dir = _set_dir("left", mini_player_dir)
		mini_player.rotation_degrees -= 90
		$background/road.flip_h = true
		$background/road.play("turn")
		$background/AnimationPlayerLeft.play("turn_left")
		$background/AnimationPlayerRight.play("turn_left")
	if area.name == "mini_target":
		mini_target_dir = _set_dir("left", mini_target_dir)
		mini_target.rotation_degrees -= 90


func _on_Right_area_entered(area):
	if area.name == "mini_player":
		mini_player_dir = _set_dir("right", mini_player_dir)
		mini_player.rotation_degrees += 90
		$background/road.flip_h = false
		$background/road.play("turn")
		$background/AnimationPlayerLeft.play("turn_right")
		$background/AnimationPlayerRight.play("turn_right")
	if area.name == "mini_target":
		mini_target_dir = _set_dir("right", mini_target_dir)
		mini_target.rotation_degrees += 90


func _on_Finish_area_entered(area):
	if area.name == "mini_player":
		$AnimationPlayer.play("loading_out")
		finish = true
	if area.name == "mini_target":
		mini_target_speed = 0


func _on_Area2D_sonar_area_entered(area):
	if area.name == "mini_target":
		tracking_target = true
		mini_target.visible = true
		$Label.visible = false



func _on_Area2D_sonar_area_exited(area):
	if area.name == "mini_target":
		tracking_target = false
		mini_target.visible = false
		$Label.visible = true
		$CanvasLayer/minimap/player/Timer_last_chance.start()


func _on_Timer_last_chance_timeout():
	if tracking_target == false:
		$AnimationPlayer.play("game_over")




func _on_Timer_spawn_car_timeout():
	randomize()
	car_position = CarP[randi() % CarP.size()]
	car_timer = CarT[randi() % CarT.size()]
	if $background/AnimationPlayerLeft.current_animation == "straight" && Global.life > 0 && $AnimationPlayer.current_animation != "loading_out":
		var car = CAR.instance()
		match car_position:
			1:
				car.position = $Position_Left.position
				car._sides(true)
			2:
				car.position = $Position_Middle.position
			3:
				car.position = $Position_Right.position
				car._sides(true)
		get_parent().add_child(car)
	$Timer_spawn_car.wait_time = car_timer
