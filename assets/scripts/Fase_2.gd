extends Node2D

var OT = [3, 3, 4, 4, 5, 5, 6]
var obstacle_timer

var BT = [ 3, 3, 4, 4, 5]
var bullet_timer
var ammo = 0
var locked = false

var next_fase = false

export(Texture) var bullet_hole_texture

onready var back = [$background/Sprite0, $background/Sprite, $background/Sprite2, $background/Sprite3, 
$background/Sprite4, $background/Sprite5, $background/Sprite6,$background/Sprite7, $background/Sprite8, 
$background/Sprite9, $background/Sprite10, $background/Sprite11]
export var back_velocity = 1.0
var back_original_position : Array = [0, 1, 2, 3, 4, 5, 6, 7, 8 ,9 ,10, 11]

onready var rail_road = [$rail_road/road0, $rail_road/road1, $rail_road/road2, $rail_road/road3, 
$rail_road/road4, $rail_road/road5, $rail_road/road6, $rail_road/road7, $rail_road/road8,
$rail_road/road9, $rail_road/road10, $rail_road/road11]
var rail_road_original_position : Array = [0, 1, 2, 3, 4, 5, 6, 7, 8 ,9 ,10, 11]

const outdoor = preload("res://assets/objects/obstacle_outdoor.tscn")

const BULLET = preload("res://assets/objects/AR_bullet.tscn")
const HOLE = preload("res://assets/objects/bullet_hole.tscn")





func _ready():
	Global.fase = "Fase_2"
	DB._save_new_game(DB.current_save)
	$Camera_Fase_2.current = true
	for i in back.size():
		back_original_position[i] = back[i].position.x
	
	for i in rail_road.size():
		rail_road_original_position[i] = rail_road[i].position.x
	
	randomize()
	obstacle_timer = OT[randi() % OT.size()]
	bullet_timer = BT[randi() % BT.size()]
	
	$Timer_Obstacle.wait_time = obstacle_timer
	$Timer_Obstacle.start()
	
	$Timer_bullet_warning.wait_time = bullet_timer - 0.5
	$Timer_bullet_warning.start()
	
	$Timer_bullet.wait_time = bullet_timer
	$Timer_bullet.start()
	
	
	$bullet_positions/warning.visible = false



func _physics_process(delta):
	if Global.dead == true:
		$Player.position.x -= 20
	else:
		$Camera_Fase_2.position.x = $Player.position.x + 500
	$Position2D_obstacle.position.x = $Player.position.x + (2000-170)
	if locked == false:
		$bullet_positions.position.x = $Player.position.x + (290-170)
		$position_bullet_1.position.x = $Player.position.x + (290-170)
		$position_bullet_2.position.x = $Player.position.x + (277-170)
		$position_bullet_3.position.x = $Player.position.x + (303-170)
		$position_bullet_4.position.x = $Player.position.x + (281-170)
		$position_bullet_5.position.x = $Player.position.x + (300-170)
	
	
	
	
	for i in back.size():
		back[i].position.x -= back_velocity
		if back[i].position.x <= (back_original_position[i] - 1280):
			back[i].position.x = back_original_position[i]
	
	for i in rail_road.size():
		rail_road[i].position.x -= 15
		if rail_road[i].position.x <= (rail_road_original_position[i] - 1280):
			rail_road[i].position.x = rail_road_original_position[i]
	


func _on_Timer_Obstacle_timeout():
	randomize()
	obstacle_timer = OT[randi() % OT.size()]
	$Timer_Obstacle.wait_time = obstacle_timer
	var obstacle = outdoor.instance()
	add_child(obstacle)
	obstacle.position = $Position2D_obstacle.position


func _on_Timer_bullet_warning_timeout():
	#$bullet_positions/warning.visible = true
	locked = true


func _on_Timer_bullet_timeout():
	$bullet_positions/warning.visible = false
	ammo = 5
	$Timer_shoot.start()
	
	bullet_timer = BT[randi() % BT.size()]
	$Timer_bullet_warning.wait_time = bullet_timer - 0.5
	$Timer_bullet_warning.start()
	
	$Timer_bullet.wait_time = bullet_timer


func _on_Timer_shoot_timeout():
	if ammo > 0:
		
		$bullet_positions/audio_shoot.play()
		var bullet = BULLET.instance()
		add_child(bullet)
		bullet._set_direction(-2)
		bullet._set_layer([0,0])
		
		var bullet_hole = HOLE.instance()
		bullet_hole.texture = bullet_hole_texture
		add_child(bullet_hole)
		match ammo:
			5:
				bullet.position = $position_bullet_1.position
			4:
				bullet.position = $position_bullet_2.position
			3:
				bullet.position = $position_bullet_3.position
			2:
				bullet.position = $position_bullet_4.position
			1:
				bullet.position = $position_bullet_5.position
		ammo -= 1
		bullet_hole.position = bullet.position
	else:
		#$bullet_positions/audio_shoot.stop()
		locked = false
		$Timer_shoot.stop()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "game_over":
		get_tree().change_scene("res://assets/interfaces/game_over.tscn")
	if anim_name == "loading_out":
		get_tree().change_scene("res://assets/cutscenes/cutscene_3.tscn")


func _on_Area2D_Next_Fase_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("loading_out")
		next_fase = true


func _on_VisibilityNotifier2D_screen_exited():
	if next_fase == false:
		Global.life = 0
		$AnimationPlayer.play("game_over")
