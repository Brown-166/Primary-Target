extends Control

var action
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	Global.dead = false
	Global.life = 100
	Global.stamina = 100
	$Menu/Button_Restart.grab_focus()
	$Menu/Button_Restart.disabled = false
	$Menu/Button_Quit.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _loading_out():
	$Menu/Button_Restart.disabled = true
	$Menu/Button_Quit.disabled = true
	$AnimationPlayer.play("loading_out")
	

func _on_Button_Restart_pressed():
	$audio_btn.play()
	DB._load_game(DB.current_save)
	action = "restart"
	_loading_out()


func _on_Button_Quit_pressed():
	$audio_btn.play()
	action = "quit"
	_loading_out()



func _on_AnimationPlayer_animation_finished(anim_name):
	if action == "restart":
		if Global.fase in ["Test","Fase_1", "Fase_2", "Fase_3", "Fase_4", "Fase_5", "Fase_6"]:
			get_tree().change_scene("res://assets/scenes/"+ Global.fase +".tscn")
		else:
			get_tree().change_scene("res://assets/cutscenes/"+ Global.fase +".tscn")
	if action == "quit":
		get_tree().change_scene("res://assets/interfaces/main_menu.tscn")


func _on_Button_Restart_focus_entered():
	if $AnimationPlayer.is_playing() == false:
		$audio_select.play()


func _on_Button_Quit_focus_entered():
	$audio_select.play()
