extends Node2D

var skip = false

export var enemy_ar_flip : bool
onready var enemy_ar_parts = [
	$Enemy_AR/Upper_Right/Head, $Enemy_AR/Upper_Right/Chest, 
	$Enemy_AR/Upper_Right/R_Arm, $Enemy_AR/Upper_Right/R_Forearm, $Enemy_AR/Upper_Right/R_Forearm/R_Hand, 
	$Enemy_AR/Upper_Left/L_Arm, $Enemy_AR/Upper_Left/L_Forearm, $Enemy_AR/Upper_Left/L_Forearm/L_Hand, 
	$Enemy_AR/Lower/R_Thigh, $Enemy_AR/Lower/R_Leg, $Enemy_AR/Lower/R_Leg/R_Foot,
	$Enemy_AR/Lower/L_Thigh, $Enemy_AR/Lower/L_Leg, $Enemy_AR/Lower/L_Leg/L_Foot,
	$Enemy_AR/Upper_Right/Weapon_Set, $Enemy_AR/Upper_Right/Weapon_Set/Weapon, 
	$Enemy_AR/Upper_Right/Weapon_Set/Reloader]
onready var enemy_ar_sprites = [
	$Enemy_AR/Upper_Right/Head/Sprite, $Enemy_AR/Upper_Right/Chest/Sprite, 
	$Enemy_AR/Upper_Right/R_Arm/Sprite, $Enemy_AR/Upper_Right/R_Forearm/Sprite, $Enemy_AR/Upper_Right/R_Forearm/R_Hand/Sprite, 
	$Enemy_AR/Upper_Left/L_Arm/Sprite, $Enemy_AR/Upper_Left/L_Forearm/Sprite, $Enemy_AR/Upper_Left/L_Forearm/L_Hand/Sprite, 
	$Enemy_AR/Lower/R_Thigh/Sprite, $Enemy_AR/Lower/R_Leg/Sprite, $Enemy_AR/Lower/R_Leg/R_Foot/Sprite,
	$Enemy_AR/Lower/L_Thigh/Sprite, $Enemy_AR/Lower/L_Leg/Sprite, $Enemy_AR/Lower/L_Leg/L_Foot/Sprite,
	$Enemy_AR/Upper_Right/Weapon_Set/Weapon/Sprite, 
	$Enemy_AR/Upper_Right/Weapon_Set/Reloader/Sprite]
var enemy_ar_or_position_x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 
	14, 15, 16]

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

export var boss_blue_flip : bool
onready var boss_blue_parts = [
	$Boss_Blue/Upper_Right, $Boss_Blue/Upper_Left, $Boss_Blue/Lower,
	$Boss_Blue/Upper_Right/Head, $Boss_Blue/Upper_Right/Chest,
	$Boss_Blue/Upper_Right/R_Arm, $Boss_Blue/Upper_Right/R_Arm/R_Forearm, $Boss_Blue/Upper_Right/R_Arm/R_Forearm/R_Hand,
	$Boss_Blue/Upper_Left/L_Arm, $Boss_Blue/Upper_Left/L_Arm/L_Forearm, $Boss_Blue/Upper_Left/L_Arm/L_Forearm/L_Hand,
	$Boss_Blue/Lower/R_Thigh, $Boss_Blue/Lower/R_Thigh/R_Leg, $Boss_Blue/Lower/R_Thigh/R_Leg/R_Foot,
	$Boss_Blue/Lower/L_Thigh, $Boss_Blue/Lower/L_Thigh/L_Leg, $Boss_Blue/Lower/L_Thigh/L_Leg/L_Foot,
	$Boss_Blue/Upper_Right/Katar, $Boss_Blue/Upper_Left/Katar]
onready var boss_blue_sprites = [
	$Boss_Blue/Upper_Right/Head/Sprite, $Boss_Blue/Upper_Right/Chest/Sprite,
	$Boss_Blue/Upper_Right/R_Arm/Sprite, $Boss_Blue/Upper_Right/R_Arm/R_Forearm/Sprite, $Boss_Blue/Upper_Right/R_Arm/R_Forearm/R_Hand/Sprite,
	$Boss_Blue/Upper_Left/L_Arm/Sprite, $Boss_Blue/Upper_Left/L_Arm/L_Forearm/Sprite, $Boss_Blue/Upper_Left/L_Arm/L_Forearm/L_Hand/Sprite,
	$Boss_Blue/Lower/R_Thigh/Sprite, $Boss_Blue/Lower/R_Thigh/R_Leg/Sprite, $Boss_Blue/Lower/R_Thigh/R_Leg/R_Foot/Sprite,
	$Boss_Blue/Lower/L_Thigh/Sprite, $Boss_Blue/Lower/L_Thigh/L_Leg/Sprite, $Boss_Blue/Lower/L_Thigh/L_Leg/L_Foot/Sprite,
	$Boss_Blue/Upper_Right/Katar/Hilt, $Boss_Blue/Upper_Right/Katar/Blade,
	$Boss_Blue/Upper_Left/Katar/Hilt, $Boss_Blue/Upper_Left/Katar/Blade]
var boss_blue_or_position_x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 
	14, 15, 16, 17, 18, 19]

export var boss_red_flip : bool
onready var boss_red_parts = [
	$Boss_Red/Upper_Right, $Boss_Red/Upper_Left, $Boss_Red/Lower,
	$Boss_Red/Upper_Right/Head, $Boss_Red/Upper_Right/Chest,
	$Boss_Red/Upper_Right/R_Arm, $Boss_Red/Upper_Right/R_Arm/R_Forearm, $Boss_Red/Upper_Right/R_Arm/R_Forearm/R_Hand,
	$Boss_Red/Upper_Left/L_Arm, $Boss_Red/Upper_Left/L_Arm/L_Forearm, $Boss_Red/Upper_Left/L_Arm/L_Forearm/L_Hand,
	$Boss_Red/Lower/R_Thigh, $Boss_Red/Lower/R_Thigh/R_Leg, $Boss_Red/Lower/R_Thigh/R_Leg/R_Foot,
	$Boss_Red/Lower/L_Thigh, $Boss_Red/Lower/L_Thigh/L_Leg, $Boss_Red/Lower/L_Thigh/L_Leg/L_Foot,
	$Boss_Red/Upper_Right/Hammer]
onready var boss_red_sprites = [
	$Boss_Red/Upper_Right/Head/Sprite, $Boss_Red/Upper_Right/Chest/Sprite,
	$Boss_Red/Upper_Right/R_Arm/Sprite, $Boss_Red/Upper_Right/R_Arm/R_Forearm/Sprite, $Boss_Red/Upper_Right/R_Arm/R_Forearm/R_Hand/Sprite,
	$Boss_Red/Upper_Left/L_Arm/Sprite, $Boss_Red/Upper_Left/L_Arm/L_Forearm/Sprite, $Boss_Red/Upper_Left/L_Arm/L_Forearm/L_Hand/Sprite,
	$Boss_Red/Lower/R_Thigh/Sprite, $Boss_Red/Lower/R_Thigh/R_Leg/Sprite, $Boss_Red/Lower/R_Thigh/R_Leg/R_Foot/Sprite,
	$Boss_Red/Lower/L_Thigh/Sprite, $Boss_Red/Lower/L_Thigh/L_Leg/Sprite, $Boss_Red/Lower/L_Thigh/L_Leg/L_Foot/Sprite,
	$Boss_Red/Upper_Right/Hammer/Hilt, $Boss_Red/Upper_Right/Hammer/Head]
var boss_red_or_position_x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 
	14, 15, 16, 17, 18]





onready var background_1 = [$background_1/city/Sprite0, $background_1/city/Sprite, 
$background_1/city/Sprite2, $background_1/city/Sprite3, $background_1/city/Sprite4, 
$background_1/city/Sprite5, $background_1/city/Sprite6,$background_1/city/Sprite7, 
$background_1/city/Sprite8, $background_1/city/Sprite9, $background_1/city/Sprite10, 
$background_1/city/Sprite11, $background_1/city/Sprite12, $background_1/city/Sprite13,
$background_1/city/Sprite14, $background_1/city/Sprite15, $background_1/city/Sprite16]
export var background_1_velocity = 1.0
var background_1_original_position : Array = [0, 1, 2, 3, 4, 5, 6, 7, 8 ,9 ,10, 11, 12, 13,
14, 15, 16]


onready var rail_road = [$background_2/rail_road/road0, $background_2/rail_road/road1, 
$background_2/rail_road/road2, $background_2/rail_road/road3, $background_2/rail_road/road4, 
$background_2/rail_road/road5, $background_2/rail_road/road6, $background_2/rail_road/road7, 
$background_2/rail_road/road8, $background_2/rail_road/road9, $background_2/rail_road/road10,
$background_2/rail_road/road11, $background_2/rail_road/road12, $background_2/rail_road/road13, 
$background_2/rail_road/road14]

var road_original_position : Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 
12, 13, 14]

onready var city = [$background_2/city_background/city0, $background_2/city_background/city1, 
$background_2/city_background/city2, $background_2/city_background/city3, 
$background_2/city_background/city4,$background_2/city_background/city5, 
$background_2/city_background/city6, $background_2/city_background/city7,
$background_2/city_background/city8, $background_2/city_background/city9, 
$background_2/city_background/city10,$background_2/city_background/city11, 
$background_2/city_background/city12, $background_2/city_background/city13,
$background_2/city_background/city14]

var city_original_positon : Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 
12, 13, 14]





func _enemy_ar_flip():
	if enemy_ar_flip == false:
		enemy_ar_flip = true
	else:
		enemy_ar_flip = false


func _player_flip():
	if player_flip == false:
		player_flip = true
	else:
		player_flip = false


func _boss_blue_flip():
	if boss_blue_flip == false:
		boss_blue_flip = true
	else:
		boss_blue_flip = false


func _hades_flip():
	if hades_flip == false:
		hades_flip = true
	else:
		hades_flip = false


func _boss_red_flip():
	if boss_red_flip == false:
		boss_red_flip = true
	else:
		boss_red_flip = false



func _ready():
	Global.fase = name
	DB._save_new_game(DB.current_save)
	
	if get_node("Enemy_AR"):
		for i in enemy_ar_parts.size():
			enemy_ar_or_position_x[i] = enemy_ar_parts[i].position.x
	
	if get_node("Player"):
		for i in player_parts.size():
			player_or_position_x[i] = player_parts[i].position.x
	
	if get_node("Hades"):
		for i in hades_parts.size():
			hades_or_position_x[i] = hades_parts[i].position.x
	
	if get_node("Boss_Blue"):
		for i in boss_blue_parts.size():
			boss_blue_or_position_x[i] = boss_blue_parts[i].position.x
	
	if get_node("Boss_Red"):
		for i in boss_red_parts.size():
			boss_red_or_position_x[i] = boss_red_parts[i].position.x
	
	if Global.fase == "cutscene_3":
		for i in background_1.size():
			background_1_original_position[i] = background_1[i].position.x
		
		for i in rail_road.size():
			road_original_position[i] = rail_road[i].position.x
	
		for i in city.size():
			city_original_positon[i] = city[i].position.x
	
	
	$CanvasLayer/Skip_button.visible = false
	$CanvasLayer/Skip_button.value = 0.1




func _physics_process(delta):
	if Global.fase == "cutscene_3":
		for i in background_1.size():
			background_1[i].position.x -= background_1_velocity
			if background_1[i].position.x <= (background_1_original_position[i] - 1280):
				background_1[i].position.x = background_1_original_position[i]
		
		for i in rail_road.size():
			rail_road[i].position.x -= 15
			if rail_road[i].position.x <= (road_original_position[i] - 640):
				rail_road[i].position.x = road_original_position[i]
		
		for i in city.size():
			city[i].position.x -= 1
			if city[i].position.x <= (city_original_positon[i] - 640):
				city[i].position.x = city_original_positon[i]
	
	
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
		match Global.fase:
			"cutscene_1":
				get_tree().change_scene("res://assets/scenes/Fase_1.tscn")
			"cutscene_2":
				get_tree().change_scene("res://assets/scenes/Fase_2.tscn")
			"cutscene_3":
				get_tree().change_scene("res://assets/scenes/Fase_3.tscn")
			"cutscene_4":
				get_tree().change_scene("res://assets/scenes/Fase_4.tscn")
			"cutscene_5":
				get_tree().change_scene("res://assets/scenes/Fase_5.tscn")
			"cutscene_6":
				get_tree().change_scene("res://assets/scenes/Fase_6.tscn")
			"cutscene_7":
				get_tree().change_scene("res://assets/interfaces/credits.tscn")
		


func _on_Timer_Flip_timeout():
	if get_node("Enemy_AR"):
		if enemy_ar_flip == true:
			for i in enemy_ar_parts.size():
				if enemy_ar_parts[i].position.x == enemy_ar_or_position_x[i]:
					enemy_ar_parts[i].position.x *= -1
					enemy_ar_parts[i].rotation_degrees *= -1
			for i in enemy_ar_sprites.size():
				enemy_ar_sprites[i].flip_h = true
		else:
			for i in enemy_ar_sprites.size():
				enemy_ar_sprites[i].flip_h = false
	
	
	if get_node("Player"):
		if player_flip == true:
			for i in player_parts.size():
				if player_parts[i].position.x == player_or_position_x[i]:
					player_parts[i].position.x *= -1
					player_parts[i].rotation_degrees *= -1
			for i in player_sprites.size():
				player_sprites[i].flip_h = true
		else:
			for i in player_sprites.size():
				player_sprites[i].flip_h = false
	
	
	if get_node("Hades"):
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
	
	
	if get_node("Boss_Blue"):
		if boss_blue_flip == true:
			for i in boss_blue_parts.size():
				if boss_blue_parts[i].position.x == boss_blue_or_position_x[i]:
					boss_blue_parts[i].position.x *= -1
					boss_blue_parts[i].rotation_degrees *= -1
			for i in boss_blue_sprites.size():
				boss_blue_sprites[i].flip_h = true
		else:
			for i in boss_blue_sprites.size():
				boss_blue_sprites[i].flip_h = false
	
	
	if get_node("Boss_Red"):
		if boss_red_flip == true:
			for i in boss_red_parts.size():
				if boss_red_parts[i].position.x == boss_red_or_position_x[i]:
					boss_red_parts[i].position.x *= -1
					boss_red_parts[i].rotation_degrees *= -1
			for i in boss_red_sprites.size():
				boss_red_sprites[i].flip_h = true
		else:
			for i in boss_red_sprites.size():
				boss_red_sprites[i].flip_h = false
