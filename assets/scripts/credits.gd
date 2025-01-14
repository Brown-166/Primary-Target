extends Control

onready var back1 = $background
onready var back2 = $background2
export var velocity = 1.0
var original_position1
var original_position2
var originalLenght = 0.0
var skip = false

func _ready():
	original_position1 = back1.position.x
	original_position2 = back2.position.x
	$Menu/Skip_button.visible = false
	$Menu/Skip_button.value = 0.1
	DB._load_DB()
	match DB.language:
		"portuguese":
			$Menu/Label.text = """Feito por:
			Pedro Brown
			e
			Samuel Maia"""
		"english":
			$Menu/Label.text = """Made by:
			Pedro Brown
			and
			Samuel Maia"""
		"spanish":
			$Menu/Label.text = """Hecho por:
			Pedro Brown
			y
			Samuel Maia"""
	
	
func _physics_process(delta):
	back1.position.x -= velocity
	back2.position.x -= velocity
	if back1.position.x <= -2496:
		back1.position.x = original_position1
	if back2.position.x <= original_position1:
		back2.position.x = original_position2
	
	if skip == false:
		if Input.is_action_pressed("space"):
			$Menu/Skip_button.value *= 1.1
		else:
			if $Menu/Skip_button.value > 0.1:
				$Menu/Skip_button.value /= 1.1
		
		if $Menu/Skip_button.value < 0.1:
			$Menu/Skip_button.value = 0.1
		
		if $Menu/Skip_button.value == 0.1:
			$Menu/Skip_button.visible = false
		else:
			$Menu/Skip_button.visible = true
		
		if $Menu/Skip_button.value == 100:
			skip = true
			$AnimationPlayer.play("load_out")



func _on_AnimationPlayer_animation_finished(anim_name):
	if skip == true:
		get_tree().change_scene("res://assets/interfaces/main_menu.tscn")
