extends Node2D

var skip = false



export var player_flip : bool
onready var player_parts = [
	$Player/Upper_Right, $Player/Upper_Left, $Player/Lower,
	$Player/Upper_Right/Head, $Player/Upper_Right/Chest,
	$Player/Upper_Right/R_Arm, $Player/Upper_Right/R_Arm/R_Forearm, $Player/Upper_Right/R_Arm/R_Forearm/R_Hand,
	$Player/Upper_Left/L_Arm, $Player/Upper_Left/L_Arm/L_Forearm, $Player/Upper_Left/L_Arm/L_Forearm/L_Hand,
	$Player/Lower/R_Thigh, $Player/Lower/R_Thigh/R_Leg, $Player/Lower/R_Thigh/R_Leg/R_Foot,
	$Player/Lower/L_Thigh, $Player/Lower/L_Thigh/L_Leg, $Player/Lower/L_Thigh/L_Leg/L_Foot,
	$Player/Upper_Right/Katana]
onready var player_sprites = [
	$Player/Upper_Right/Head, $Player/Upper_Right/Chest,
	$Player/Upper_Right/R_Arm, $Player/Upper_Right/R_Arm/R_Forearm, $Player/Upper_Right/R_Arm/R_Forearm/R_Hand,
	$Player/Upper_Left/L_Arm, $Player/Upper_Left/L_Arm/L_Forearm, $Player/Upper_Left/L_Arm/L_Forearm/L_Hand,
	$Player/Lower/R_Thigh, $Player/Lower/R_Thigh/R_Leg, $Player/Lower/R_Thigh/R_Leg/R_Foot,
	$Player/Lower/L_Thigh, $Player/Lower/L_Thigh/L_Leg, $Player/Lower/L_Thigh/L_Leg/L_Foot,
	$Player/Upper_Right/Katana/Blade, $Player/Upper_Right/Katana/Hilt]
var player_or_position_x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 
	14, 15, 16, 17]
var player_or_rotation = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 
	14, 15, 16, 17]

export var hades_flip : bool
onready var hades_parts = [
	$Hades/Upper_Right, $Hades/Upper_Left, $Hades/Lower,
	$Hades/Upper_Right/Head, $Hades/Upper_Right/Chest,
	$Hades/Upper_Right/R_Arm, $Hades/Upper_Right/R_Arm/R_Forearm, $Hades/Upper_Right/R_Arm/R_Forearm/R_Hand,
	$Hades/Upper_Left/L_Arm, $Hades/Upper_Left/L_Arm/L_Forearm, $Hades/Upper_Left/L_Arm/L_Forearm/L_Hand,
	$Hades/Lower/R_Thigh, $Hades/Lower/R_Thigh/R_Leg, $Hades/Lower/R_Thigh/R_Leg/R_Foot,
	$Hades/Lower/L_Thigh, $Hades/Lower/L_Thigh/L_Leg, $Hades/Lower/L_Thigh/L_Leg/L_Foot]
onready var hades_sprites = [
	$Hades/Upper_Right/Head, $Hades/Upper_Right/Chest,
	$Hades/Upper_Right/R_Arm, $Hades/Upper_Right/R_Arm/R_Forearm, $Hades/Upper_Right/R_Arm/R_Forearm/R_Hand,
	$Hades/Upper_Left/L_Arm, $Hades/Upper_Left/L_Arm/L_Forearm, $Hades/Upper_Left/L_Arm/L_Forearm/L_Hand,
	$Hades/Lower/R_Thigh, $Hades/Lower/R_Thigh/R_Leg, $Hades/Lower/R_Thigh/R_Leg/R_Foot,
	$Hades/Lower/L_Thigh, $Hades/Lower/L_Thigh/L_Leg, $Hades/Lower/L_Thigh/L_Leg/L_Foot]
var hades_or_position_x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]
var hades_or_rotation = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]




func _player_flip():
	if player_flip == false:
		player_flip = true
	else:
		player_flip = false


func _hades_flip():
	if hades_flip == false:
		hades_flip = true
	else:
		hades_flip = false


func _ready():
	Global.fase = "cutscene_7"
	
	for i in player_parts.size():
		player_or_position_x[i] = player_parts[i].position.x
		player_or_rotation[i] = player_parts[i].rotation_degrees
	
	for i in hades_parts.size():
		hades_or_position_x[i] = hades_parts[i].position.x
	
	
	$Player_anim.get_animation("kick")
	
	
	
	$CanvasLayer/Skip_button.visible = false
	$CanvasLayer/Skip_button.value = 0.1


func _physics_process(delta):
	if skip == false:
		if Input.is_action_pressed("space"):
			$CanvasLayer/Skip_button.value *= 1.1
		else:
			if $CanvasLayer/Skip_button.value > 0.1:
				$CanvasLayer/Skip_button.value /= 1.1
		
		if $CanvasLayer/Skip_button.value < 0.1:
			$CanvasLayer/Skip_button.value = 0.1
		
		if $CanvasLayer/Skip_button.value == 0.1:
			$CanvasLayer/Skip_button.visible = false
		else:
			$CanvasLayer/Skip_button.visible = true
		
		if $CanvasLayer/Skip_button.value == 100:
			skip = true
			$AnimationPlayer.play("loading_out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "loading_in":
		$AnimationPlayer.play("cutscene")
		$Player_anim.play("cutscene")
	if anim_name == "cutscene":
		$AnimationPlayer.play("loading_out")
	if anim_name == "loading_out":
		get_tree().change_scene("res://assets/scenes/Fase_1.tscn")


func _on_Timer_Flip_timeout():
	if player_flip == true:
		for i in player_parts.size():
			if player_parts[i].position.x == player_or_position_x[i] || player_parts[i].rotation_degrees == player_or_rotation[i]:
				print("flip")
				player_parts[i].position.x *= -1
				player_parts[i].rotation_degrees *= -1
		for i in player_sprites.size():
			player_sprites[i].flip_h = true
	else:
		for i in player_sprites.size():
			player_sprites[i].flip_h = false
	
	
	if hades_flip == true:
		for i in hades_parts.size():
			if hades_parts[i].position.x == hades_or_position_x[i]:
				hades_parts[i].position.x *= -1
				hades_parts[i].rotation_degrees *= -1
		for i in hades_sprites.size():
			hades_sprites[i].flip_h = true
	else:
		for i in hades_sprites.size():
			hades_sprites[i].flip_h = false
