extends Node2D

var skip = false

export var enemy_ar_flip : bool

export var player_flip : bool

export var hades_flip : bool

export var boss_blue_flip : bool

export var boss_red_flip : bool


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


func _flip():
	if get_node("Enemy_AR"):
		if enemy_ar_flip == false:
			get_node("Enemy_AR").scale.x = 2
		else:
			get_node("Enemy_AR").scale.x = -2
	
	
	if get_node("Player"):
		if player_flip == false:
			get_node("Player").scale.x = 2
		else:
			get_node("Player").scale.x = -2
	
	
	if get_node("Hades"):
		if hades_flip == false:
			get_node("Hades").scale.x = 2
		else:
			get_node("Hades").scale.x = -2
	
	
	if get_node("Boss_Blue"):
		if boss_blue_flip == false:
			get_node("Boss_Blue").scale.x = 2
		else:
			get_node("Boss_Blue").scale.x = -2
	
	
	if get_node("Boss_Red"):
		if boss_red_flip == false:
			get_node("Boss_Red").scale.x = 2
		else:
			get_node("Boss_Red").scale.x = -2


func _ready():
	Global.fase = name
	DB._save_new_game(DB.current_save)
	
	
	if Global.fase == "cutscene_3":
		for i in background_1.size():
			background_1_original_position[i] = background_1[i].position.x
		
		for i in rail_road.size():
			road_original_position[i] = rail_road[i].position.x
	
		for i in city.size():
			city_original_positon[i] = city[i].position.x
	
	if Global.fase == "cutscene_7":
		match DB.language:
			"portuguese":
				$CanvasLayer/Label.text = "MISSÃO CUMPRIDA"
			"english":
				$CanvasLayer/Label.text = "MISSION ACCOMPLISHED"
			"spanish":
				$CanvasLayer/Label.text = "MISIÓN CUMPLIDA"
	
	$CanvasLayer/Skip_button.visible = false
	$CanvasLayer/Skip_button.value = 0.1




func _physics_process(delta):
	_flip()
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
	else:
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
