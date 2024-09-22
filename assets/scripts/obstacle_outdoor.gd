extends KinematicBody2D

var velocity = 20

var C = ["eeff00", "ff0000", "00fff0", "ff5000", "00ff00", "5000ff", "ffffff", "2b2b2b"]
var color
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	color = C[randi() % C.size()]
	$outdoor.modulate = color


func _physics_process(delta):
	position.x -= velocity


func _on_Area2D_outdoor_body_entered(body):
	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
