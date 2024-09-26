extends Node2D

var OT = [3, 3, 4, 4, 5, 5, 6]
var obstacle_timer

var BT = [2, 2, 3, 3, 4, 4, 5]
var bullet_timer
var ammo = 0
var locked = false

const outdoor = preload("res://assets/objects/obstacle_outdoor.tscn")

const BULLET = preload("res://assets/objects/AR_bullet.tscn")



func _ready():
	Global.fase = "Fase_2"
	$Camera_Fase2.current = true
	
	randomize()
	obstacle_timer = OT[randi() % OT.size()]
	bullet_timer = BT[randi() % BT.size()]
	
	$Timer_Obstacle.wait_time = obstacle_timer
	#$Timer_Obstacle.start()
	
	$Timer_bullet_warning.wait_time = bullet_timer - 0.5
	$Timer_bullet_warning.start()
	
	$Timer_bullet.wait_time = bullet_timer
	$Timer_bullet.start()
	
	
	$Position2D_bullet/warning.visible = false



func _physics_process(delta):
	$Camera_Fase2.position.x = $Player.position.x + 500
	$Position2D_obstacle.position.x = $Player.position.x + (2000-170)
	if locked == false:
		$Position2D_bullet.position.x = $Player.position.x + (290-170)


func _on_Timer_Obstacle_timeout():
	print("obstacle")
	randomize()
	obstacle_timer = OT[randi() % OT.size()]
	$Timer_Obstacle.wait_time = obstacle_timer
	var obstacle = outdoor.instance()
	get_parent().add_child(obstacle)
	obstacle.position = $Position2D_obstacle.position


func _on_Timer_bullet_warning_timeout():
	$Position2D_bullet/warning.visible = true
	locked = true


func _on_Timer_bullet_timeout():
	$Position2D_bullet/warning.visible = false
	ammo = 5
	$Timer_shoot.start()
	
	bullet_timer = BT[randi() % BT.size()]
	$Timer_bullet_warning.wait_time = bullet_timer - 0.5
	$Timer_bullet_warning.start()
	
	$Timer_bullet.wait_time = bullet_timer


func _on_Timer_shoot_timeout():
	if ammo > 0:
		$Position2D_bullet/audio_shoot.play()
		print("shoot")
		var bullet = BULLET.instance()
		bullet._set_direction(-2)
		match ammo:
			5:
				print("5")
				bullet.position = $Position2D_bullet/position_bullet_1.position
			4:
				print("4")
				bullet.position = $Position2D_bullet/position_bullet_2.position
			3:
				print("3")
				bullet.position = $Position2D_bullet/position_bullet_3.position
			2:
				print("2")
				bullet.position = $Position2D_bullet/position_bullet_4.position
			1:
				print("1")
				bullet.position = $Position2D_bullet/position_bullet_5.position
		get_parent().add_child(bullet)
		ammo -= 1
	else:
		$Position2D_bullet/audio_shoot.stop()
		locked = false
		$Timer_shoot.stop()
