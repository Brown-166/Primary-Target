extends KinematicBody2D

export var sides : bool

var velocity = Vector2.ZERO
var speed : int
var max_speed = 60
onready var player = get_parent().get_node("Player_motorcycle")
onready var road = get_parent().get_node("background/road")

var C = ["242347", "b36b00", "8c1c1c", "042407", "f5f54c", "63b0a6", "dbdbdb", "4a4a4a", "0d0d0d"]
var color

onready var sprites = [$car, $car/color, $car/tire_back]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _sides(check):
	if check == true:
		set_collision_mask_bit(3, true)

# Called when the node enters the scene tree for the first time.
func _ready():
	_sides(sides)
	randomize()
	color = C[randi() % C.size()]
	$car/color.modulate = color


func _physics_process(delta):
	if Global.motorcycle_speed == 100:
		speed = 4.5
	elif Global.motorcycle_speed < 100 && Global.motorcycle_speed >= 90:
		speed = 4
	elif Global.motorcycle_speed < 90 && Global.motorcycle_speed >= 80:
		speed = 3
	elif Global.motorcycle_speed < 80 && Global.motorcycle_speed >= 70:
		speed = 2
	elif Global.motorcycle_speed < 70 && Global.motorcycle_speed >= 60:
		speed = 1
#	elif player.foward < 60 && player.foward >= 50:
#		speed = 0
#	elif player.foward < 50 && player.foward >= 40:
#		speed = -1
#	elif player.foward < 40 && player.foward >= 30:
#		speed = -2
#	elif player.foward < 30 && player.foward >= 20:
#		speed = -3
#	elif player.foward < 20 && player.foward >= 10:
#		speed = -4
#	elif player.foward < 10:
#		speed = -5
	
	if speed > 0:
		velocity.y += speed
	elif speed < 0:
		velocity.y -= speed
		if global_position.x > 640:
			global_position.x -= 1
		elif global_position.x < 640:
			global_position.x += 1
#		if Input.is_action_pressed("ui_right"):
#			velocity.x += speed
#			if velocity.x >= 70:
#				$motorcycle/tire_front.position.x = 63
#				$CollisionBack.disabled = true
#				$CollisionSide.disabled = false
#				$CollisionSide.position.x = -7
#				$CollisionSide.rotation_degrees = 57
#				for i in sprites.size():
#					sprites[i].play("side")
#					sprites[i].flip_h = false
#		elif Input.is_action_pressed("ui_left"):
#			velocity.x -= speed
#			if velocity.x <= -70:
#				$motorcycle/tire_front.position.x = -63
#				$CollisionBack.disabled = true
#				$CollisionSide.disabled = false
#				$CollisionSide.position.x = 7
#				$CollisionSide.rotation_degrees = -57
#				for i in sprites.size():
#					sprites[i].play("side")
#					sprites[i].flip_h = true
#		else:
#			if velocity.x > 0:
#				velocity.x -= 4
#			elif velocity.x < 0:
#				velocity.x += 4
##			$CollisionBack.disabled = false
##			$CollisionSide.disabled = true
#			for i in sprites.size():
#				sprites[i].play("back")
#
#		if velocity.x > 0:
#			if velocity.x > max_speed:
#				velocity.x = max_speed
#		elif velocity.x < 0:
#			if velocity.x < -max_speed:
#				velocity.x = -max_speed
		
		
	if velocity.y > 0:
		if velocity.y > max_speed:
			velocity.y = max_speed
	elif velocity.x < 0:
		if velocity.y < -max_speed:
			velocity.y = -max_speed
		
	move_and_slide(velocity * speed)
