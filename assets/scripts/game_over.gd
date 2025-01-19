extends Control

var action

onready var admob = $AdMob

var medkit
var fase
var arsenal
var trys

var video_opened = false

func _ready():
	get_tree().paused = false
	
	medkit = Global.medKit
	fase = Global.fase
	arsenal = Global.arsenal
	trys = Global.trys
	
	Global.dead = false
	Global.life = 100
	Global.stamina = 100
	Global.medKit = 1
	Global.weapon = "katana"
	Global.fase = "cutscene_1"
	Global.arsenal = ["katana", "", ""]
	Global.trys = 3
	DB._save_new_game(DB.current_save)
	
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
	if trys > 0:
		admob.load_rewarded_video()


func _on_AdMob_rewarded_video_failed_to_load(error_code):
	$Menu/Label_error_video.visible = true
	$Menu/Label_error_video.text = error_code


func _on_AdMob_rewarded_video_loaded():
	$Menu/Label.text = "Load"
	admob.show_rewarded_video()


func _on_AdMob_rewarded_video_opened():
	video_opened = true


func _on_AdMob_rewarded_video_closed():
	if video_opened == true:
		Global.medKit = medkit
		Global.fase = fase
		Global.arsenal = arsenal
		Global.trys = trys - 1
		DB._save_new_game(DB.current_save)
		action = "continue"
		_loading_out()
