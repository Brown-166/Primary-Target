extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.fase = "Fase_3"
	$Camera_Fase_3.current = true


func _physics_process(delta):
	$Camera_Fase_3.position.x = $Player.position.x + 300
