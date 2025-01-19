extends CanvasLayer

var action

onready var fase = get_parent()

var android_audio = true

func _ready():
	DB._load_DB()
	visible = true
	$Touch_Button.visible = true
	$Menu.visible = false
	$ColorRect.visible = false
	$Menu/Resume.disabled = false
	$Menu/Quit.disabled = false
	
	if fase.name in ["Test", "Fase_1", "Fase_2", "Fase_3", "Fase_4", "Fase_5", "Fase_6"]:
		$Menu/Button_Skip.disabled = true
		$Menu/Button_Skip.visible = false
		$Menu/Button_Android_controller.disabled = false
		$Menu/Button_Android_controller.visible = true
		if DB.android_controller == true:
			$Menu/Button_Android_controller.pressed = false
		else:
			android_audio = false
			$Menu/Button_Android_controller.pressed = true
	else:
		$Menu/Button_Skip.disabled = false
		$Menu/Button_Skip.visible = true
		$Menu/Button_Android_controller.disabled = true
		$Menu/Button_Android_controller.visible = false
	
	DB._load_DB()
	match DB.language:
		"portuguese":
			$Menu/Resume.text = "VOLTAR"
			$Menu/Button_Skip.text = "PULAR"
			$Menu/Button_Android_controller.text = "CONTROLES"
			$Menu/Quit.text = "SAIR"
		"english":
			$Menu/Resume.text = "RESUME"
			$Menu/Button_Skip.text = "SKIP"
			$Menu/Button_Android_controller.text = "CONTROLS"
			$Menu/Quit.text = "QUIT"
		"spanish":
			$Menu/Resume.text = "VOLVER"
			$Menu/Button_Skip.text = "SALTAR"
			$Menu/Button_Android_controller.text = "CONTROLES"
			$Menu/Quit.text = "SALIR"




func _unhandled_input(event):
	if get_tree().paused == false:
		if event.is_action_pressed("ui_cancel") || event.is_action_pressed("ui_pause"):
			$Menu/Resume.grab_focus()
			$Menu.visible = true
			$audio_btn.play()
			get_tree().paused = true


func _loading_out():
	$Menu/Resume.disabled = true
	$Menu/Button_Skip.disabled = true
	$Menu/Button_Android_controller.disabled = true
	$Menu/Quit.disabled = true
	$AnimationPlayer.play("loading_out")


func _on_Resume_pressed():
	$audio_btn.play()
	action = "resume"
	$Menu.visible = false
	get_tree().paused = false


func _on_Quit_pressed():
	$audio_btn.play()
	action = "quit"
	DB._save_new_game(DB.current_save)
	_loading_out()


func _on_AnimationPlayer_animation_finished(anim_name):
	if action == "quit":
		get_tree().change_scene("res://assets/interfaces/main_menu.tscn")


func _on_Resume_focus_entered():
	if $Menu.visible == true:
		$audio_select.play()


func _on_Quit_focus_entered():
	$audio_select.play()


func _on_Button_Skip_pressed():
	$audio_btn.play()
	fase.skip = true
	action = "skip"
	$Menu.visible = false
	get_tree().paused = false


func _on_Button_Skip_focus_entered():
	$audio_select.play()


func _on_Button_Skip_mouse_entered():
	$Menu/Button_Skip.grab_focus()


func _on_Button_Android_controller_toggled(button_pressed):
	if android_audio == true:
		$audio_btn.play()
	android_audio = true
	if button_pressed == true:
		DB.android_controller = false
		fase.get_node("android_controller").visible = false
	else:
		DB.android_controller = true
		fase.get_node("android_controller").visible = true
	DB._save_DB()


func _on_Button_Android_controller_focus_entered():
	$audio_select.play()


func _on_Button_Android_controller_mouse_entered():
	$Menu/Button_Android_controller.grab_focus()


func _on_Resume_mouse_entered():
	$Menu/Resume.grab_focus()


func _on_Quit_mouse_entered():
	$Menu/Quit.grab_focus()
