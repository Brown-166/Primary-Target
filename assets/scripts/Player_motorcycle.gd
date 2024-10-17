extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 4


onready var sprites = [$motorcycle, $motorcycle/tire_back, $motorcycle/tire_front]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
	elif Input.is_action_pressed("ui_down"):
		velocity.y += speed
	else:
		if velocity.y > 0:
			velocity.y -= 4
		elif velocity.y < 0:
			velocity.y += 4
	
	
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		if velocity.x >= 60:
			$motorcycle/tire_front.position.x = 63
			$CollisionBack.disabled = true
			$CollisionSide.disabled = false
			$CollisionSide.position.x = -7
			$CollisionSide.rotation_degrees = 57
			for i in sprites.size():
				sprites[i].play("side")
				sprites[i].flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		if velocity.x <= -60:
			$motorcycle/tire_front.position.x = -63
			$CollisionBack.disabled = true
			$CollisionSide.disabled = false
			$CollisionSide.position.x = 7
			$CollisionSide.rotation_degrees = -57
			for i in sprites.size():
				sprites[i].play("side")
				sprites[i].flip_h = true
	else:
		if velocity.x > 0:
			velocity.x -= 4
		elif velocity.x < 0:
			velocity.x += 4
		$CollisionBack.disabled = false
		$CollisionSide.disabled = true
		for i in sprites.size():
			sprites[i].play("back")
	
	velocity.normalized()
	move_and_slide(velocity * speed)
