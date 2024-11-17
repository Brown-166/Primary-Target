extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 4
var max_speed = 100
var foward = 100

var original_pol : Array  = [Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO,
Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO,
Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO]

onready var sprites = [$motorcycle, $motorcycle/tire_back, $motorcycle/tire_front, $motorcycle/moto_back]


func _crash():
	$Audio_Crash_sides.play()


func _ready():
	for i in $CollisionSide.polygon.size():
		original_pol[i] = $CollisionSide.polygon[i]


func _physics_process(delta):
	if Global.life > 0:
		if Input.is_action_just_pressed("medkit"):
			if Global.medKit > 0:
				Global.medKit -=1
				Global.life += 60
				$audio_medkit.play()
	
	
		if foward < 100:
			foward *= 1.02
		if foward > max_speed:
			foward = max_speed
		if foward <= 0:
			foward = 10
		
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
				for i in sprites.size():
					sprites[i].play("side")
					sprites[i].flip_h = false
				$motorcycle/katana_back.visible = false
				$motorcycle/katana_side_R.visible = true
				$motorcycle/katana_side_L.visible = false
		elif Input.is_action_pressed("ui_left"):
			velocity.x -= speed
			if velocity.x <= -70:
				$motorcycle/tire_front.position.x = -63
				for i in sprites.size():
					sprites[i].play("side")
					sprites[i].flip_h = true
				$motorcycle/katana_back.visible = false
				$motorcycle/katana_side_R.visible = false
				$motorcycle/katana_side_L.visible = true
		else:
			if velocity.x > 0:
				velocity.x -= 4
			elif velocity.x < 0:
				velocity.x += 4
			$CollisionBack.disabled = false
			$CollisionSide.disabled = true
			for i in sprites.size():
				sprites[i].play("back")
			$motorcycle/katana_back.visible = true
			$motorcycle/katana_side_R.visible = false
			$motorcycle/katana_side_L.visible = false
		
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
		$Audio_Running.stop()

func _on_Area2D_Player_motorcycle_area_entered(area):
	if area.name == "Area2D_car":
		if foward == 100:
			Global.life -= 20
		elif foward < 100 && foward >= 75:
			Global.life -= 15
		elif foward < 75 && foward >= 50:
			Global.life -= 10
		elif foward < 50 && foward >=25:
			Global.life -= 5
		
		foward = 0
		$Audio_Crash.play()
		if Global.life <= 0:
			Global.dead = true


func _on_Audio_Running_finished():
	$Audio_Running.play()
