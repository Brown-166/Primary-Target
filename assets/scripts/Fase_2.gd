extends Node2D

var T = [3, 3, 4, 4, 5, 5, 6]
var obstacle_timer


const outdoor = preload("res://assets/objects/obstacle_outdoor.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.fase = "Fase_2"
	$Camera_Fase2.current = true
	
	randomize()
	obstacle_timer = T[randi() % T.size()]
	$Timer_Obstacle.wait_time = obstacle_timer
	$Timer_Obstacle.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	$Camera_Fase2.position.x = $Player.position.x + 500
	$Position2D.position.x = $Player.position.x + (2000-170)


func _on_Timer_Obstacle_timeout():
	print("time")
	randomize()
	obstacle_timer = T[randi() % T.size()]
	$Timer_Obstacle.wait_time = obstacle_timer
	var obstacle = outdoor.instance()
	get_parent().add_child(obstacle)
	obstacle.position = $Position2D.position
	
