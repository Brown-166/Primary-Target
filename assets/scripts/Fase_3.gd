extends Node2D

onready var rail_road = [$rail_road/road0, $rail_road/road1, $rail_road/road2,
$rail_road/road3, $rail_road/road4, $rail_road/road5, $rail_road/road6, 
$rail_road/road7, $rail_road/road8, $rail_road/road9, $rail_road/road10,
$rail_road/road11, $rail_road/road12, $rail_road/road13]

var road_original_position : Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 
12, 13]


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.fase = "Fase_3"
	$Camera_Fase_3.current = true
	
	for i in rail_road.size():
		road_original_position[i] = rail_road[i].position.x


func _physics_process(delta):
	$Camera_Fase_3.position.x = $Player.position.x + 300
	
	for i in rail_road.size():
		rail_road[i].position.x -= 15
		if rail_road[i].position.x <= (road_original_position[i] - 640):
			rail_road[i].position.x = road_original_position[i]
