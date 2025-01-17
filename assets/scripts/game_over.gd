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
	$Menu/Button_Continue.disabled = false
	$Menu/Button_Restart.disabled = false
	$Menu/Button_Quit.disabled = false
	DB._load_DB()
	match DB.language:
		"portuguese":
			$Menu/Label.text = "FALHOU NA MISSÃO"
			$Menu/Button_Continue.text = "CONTINUAR"
			$Menu/Button_Restart.text = "RECOMEÇAR"
			$Menu/Button_Quit.text = "SAIR"
		"english":
			$Menu/Label.text = "MISSION FAILED"
			$Menu/Button_Continue.text = "CONTINUE"
			$Menu/Button_Restart.text = "RESTART"
			$Menu/Button_Quit.text = "QUIT"
		"spanish":
			$Menu/Label.text = "FALLÓ LA MISIÓN"
			$Menu/Button_Continue.text = "CONTINUAR"
			$Menu/Button_Restart.text = "RECOMENZAR"
			$Menu/Button_Quit.text = "SALIR"


func _physics_process(delta):
	$Menu/Label_trys.text = String(Global.trys) + "/3"


func _loading_out():
	$Menu/Button_Continue.disabled = true
	$Menu/Button_Restart.disabled = true
	$Menu/Button_Quit.disabled = true
	$AnimationPlayer.play("loading_out")
	

func _on_Button_Restart_pressed():
	$audio_btn.play()
	DB._load_game(DB.current_save)
	Global.life = 100
	Global.stamina = 100
	Global.medKit = 1
	Global.weapon = "katana"
	Global.fase = "cutscene_1"
	Global.arsenal = ["katana", "", ""]
	action = "restart"
	_loading_out()


func _on_Button_Quit_pressed():
	$audio_btn.play()
	action = "quit"
	_loading_out()



func _on_AnimationPlayer_animation_finished(anim_name):
	if action == "continue":
		if Global.fase in ["Test","Fase_1", "Fase_2", "Fase_3", "Fase_4", "Fase_5", "Fase_6"]:
			get_tree().change_scene("res://assets/scenes/"+ Global.fase +".tscn")
		else:
			get_tree().change_scene("res://assets/cutscenes/"+ Global.fase +".tscn")
	if action == "restart":
		Global.trys = 3
		DB._save_new_game(DB.current_save)
		get_tree().change_scene("res://assets/cutscenes/cutscene_1.tscn")
	if action == "quit":
		get_tree().change_scene("res://assets/interfaces/main_menu.tscn")


func _on_Button_Restart_focus_entered():
	if $AnimationPlayer.is_playing() == false:
		$audio_select.play()


func _on_Button_Quit_focus_entered():
	$audio_select.play()


func _on_Button_Continue_pressed():
	$audio_btn.play()
	if Global.trys > 0:
		$AdMob.load_rewarded_video()
		$AdMob.show_rewarded_video()


func _on_AdMob_rewarded_video_closed():
	Global.trys -= 1
	action = "continue"
	_loading_out()
	
