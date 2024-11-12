extends Node2D

onready var rail_road = [$rail_road/road0, $rail_road/road1, $rail_road/road2,
$rail_road/road3, $rail_road/road4, $rail_road/road5, $rail_road/road6, 
$rail_road/road7, $rail_road/road8, $rail_road/road9, $rail_road/road10,
$rail_road/road11, $rail_road/road12, $rail_road/road13, $rail_road/road14]

var road_original_position : Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 
12, 13, 14]

onready var city = [$city_background/city0, $city_background/city1, 
$city_background/city2, $city_background/city3, $city_background/city4,
$city_background/city5, $city_background/city6, $city_background/city7,
$city_background/city8, $city_background/city9, $city_background/city10,
$city_background/city11, $city_background/city12, $city_background/city13,
$city_background/city14]

var city_original_positon : Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 
12, 13, 14]

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.fase = "Fase_3"
	DB._save_new_game(DB.current_save)
	$Camera_Fase_3.current = true
	
	for i in rail_road.size():
		road_original_position[i] = rail_road[i].position.x
	
	for i in city.size():
		city_original_positon[i] = city[i].position.x


func _physics_process(delta):
	if Global.dead == true:
		$AnimationPlayer.play("game_over")
		
	$Camera_Fase_3.position.x = $Player.position.x + 300
	
	for i in rail_road.size():
		rail_road[i].position.x -= 15
		if rail_road[i].position.x <= (road_original_position[i] - 640):
			rail_road[i].position.x = road_original_position[i]
	
	for i in city.size():
		city[i].position.x -= 1
		if city[i].position.x <= (city_original_positon[i] - 640):
			city[i].position.x = city_original_positon[i]


func _on_Area2D_Next_Fase_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("loading_out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "game_over":
		get_tree().change_scene("res://assets/interfaces/game_over.tscn")
	if anim_name == "loading_out":
		get_tree().change_scene("res://assets/scenes/Fase_4.tscn")
