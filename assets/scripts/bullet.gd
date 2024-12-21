extends KinematicBody2D

var speed = 800
var velocity = Vector2.ZERO
var direction = 1
var layer : Array
var damage : int

func _set_direction(dir):
	direction = dir

func _set_layer(L):
	layer = L

func _ready():
	if Global.fase == "Fase_2":
		damage = 10
	else:
		damage = 2

func _physics_process(delta):
	if direction == 1:
		$Sprite.flip_h = false
		velocity.x = speed * delta * direction
	elif direction == -1:
		$Sprite.flip_h = true
		velocity.x = speed * delta * direction
	elif direction == -2:
		rotation_degrees = -90
		velocity.y = speed * delta * -1
	elif direction == 2:
		rotation_degrees = 90
		velocity.y = speed * delta * 1
	translate(velocity)
	
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass




func _delete():
	queue_free()

func _on_Area2D_bullet_area_entered(area):
	if layer[0] in LAYER.playerLayer || layer[1] in LAYER.playerLayer:
		if area.name == "Area2D_Block":
			if Global.stamina >= (damage * 2):
				Global.stamina -= damage * 2
				Global.blocked = true
				queue_free()
			else:
				Global.stamina -= damage * 2
				Global.life -= damage
				Global.hit = "bullet"
				queue_free()
		elif area.name == "Area2D_Player":
			if Global.dodge == false:
				Global.life -= damage
				Global.hit = "bullet"
				queue_free()
