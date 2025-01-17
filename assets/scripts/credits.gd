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
	$Menu/Button_Menu.grab_focus()
	DB._load_DB()
	match DB.language:
		"portuguese":
			$Menu/Label.text = """Feito por:
			Pedro Brown
			e
			Samuel Maia"""
			$Menu/Button_Menu.text = "MENU"
		"english":
			$Menu/Label.text = """Made by:
			Pedro Brown
			and
			Samuel Maia"""
			$Menu/Button_Menu.text = "MENU"
		"spanish":
			$Menu/Label.text = """Hecho por:
			Pedro Brown
			y
			Samuel Maia"""
			$Menu/Button_Menu.text = "MENÚ"
	
	
func _physics_process(delta):
	back1.position.x -= velocity
	back2.position.x -= velocity
	if back1.position.x <= -2496:
		back1.position.x = original_position1
	if back2.position.x <= original_position1:
		back2.position.x = original_position2



func _on_AnimationPlayer_animation_finished(anim_name):
	if skip == true:
		get_tree().change_scene("res://assets/interfaces/main_menu.tscn")


func _on_Button_Menu_pressed():
	$audio_btn.play()
	skip = true
	$AnimationPlayer.play("load_out")


func _on_Button_Menu_focus_entered():
	$audio_select.play()


func _on_Button_Menu_mouse_entered():
	$Menu/Button_Menu.grab_focus()
