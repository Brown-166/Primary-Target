extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 4
var max_speed = 100
var foward = 100

var original_pol : Array  = [Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO,
Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO,
Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO]

onready var sprites = [$motorcycle, $motorcycle/tire_back, $motorcycle/tire_front]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in $CollisionSide.polygon.size():
		original_pol[i] = $CollisionSide.polygon[i]


func _physics_process(delta):
	if Global.life > 0:
		if Input.is_action_pressed("ui_up"):
			foward += speed
			if foward > max_speed:
				foward = max_speed
		elif Input.is_action_pressed("ui_down"):
			foward -= speed
			if foward < 60:
				foward = 60
		
		$motorcycle/tire_back.speed_scale = foward/10
		$motorcycle/tire_front.speed_scale = foward/10
		
		
		
		if foward == 100:
			speed = 5
		elif foward < 100 && foward >= 75:
			speed = 4
		elif foward < 75 && foward >= 50:
			speed = 3
#		elif foward < 50 && foward >=25:
#			speed = 2
#		elif foward < 25 && foward > 0:
#			speed = 1
#		else:
#			speed = 0.5
		
		
		if Input.is_action_pressed("ui_right"):
			velocity.x += speed
			if velocity.x >= 70:
				$motorcycle/tire_front.position.x = 63
#				$CollisionBack.disabled = true
#				$CollisionSide.disabled = false
#				$CollisionSide.position.x = -7
#				$CollisionSide.rotation_degrees = 57
				for i in sprites.size():
					sprites[i].play("side")
					sprites[i].flip_h = false
#				for i in $CollisionSide.polygon.size():
#					$CollisionSide.polygon[i] = original_pol[i]
		elif Input.is_action_pressed("ui_left"):
			velocity.x -= speed
			if velocity.x <= -70:
				$motorcycle/tire_front.position.x = -63
#				$CollisionBack.disabled = true
#				$CollisionSide.disabled = false
#				$CollisionSide.position.x = 7
#				$CollisionSide.rotation_degrees = -57
				for i in sprites.size():
					sprites[i].play("side")
					sprites[i].flip_h = true
#				for i in $CollisionSide.polygon.size():
#					if $CollisionSide.polygon[i].x == original_pol[i].x:
#						$CollisionSide.polygon[i].x *= -1
		else:
			if velocity.x > 0:
				velocity.x -= 4
			elif velocity.x < 0:
				velocity.x += 4
			$CollisionBack.disabled = false
			$CollisionSide.disabled = true
			for i in sprites.size():
				sprites[i].play("back")
		
		if velocity.x > 0:
			if velocity.x > max_speed:
				velocity.x = max_speed
		elif velocity.x < 0:
			if velocity.x < -max_speed:
				velocity.x = -max_speed
		
		
		if velocity.y > 0:
			if velocity.y > max_speed:
				velocity.y = max_speed
		elif velocity.x < 0:
			if velocity.y < -max_speed:
				velocity.y = -max_speed
		
		
		Global.motorcycle_speed = foward
		move_and_slide(velocity * speed)
	else:
		foward = 0
		speed = 0
		$motorcycle/tire_back.playing = false
		$motorcycle/tire_front.playing = false

func _on_Area2D_Player_motorcycle_area_entered(area):
	if area.name == "Area2D_car":
		if foward == 100:
			Global.life -= 20
		elif foward < 100 && foward >= 75:
			Global.life -= 15
		elif foward < 75 && foward >= 50:
			Global.life -= 10
		elif foward < 50 && foward >=25:
			Global.life -= 15
		elif foward < 25 && foward > 0:
			Global.life -= 10
		
		foward = 50
		if Global.life <= 0:
			Global.dead = true
