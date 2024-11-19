extends CanvasLayer

var action



func _ready():
	visible = false
	$ColorRect.visible = false
	$Menu/Resume.disabled = false
	$Menu/Quit.disabled = false




func _unhandled_input(event):
	if get_tree().paused == false:
		if event.is_action_pressed("ui_cancel") || event.is_action_pressed("ui_pause"):
			$Menu/Resume.grab_focus()
			visible = true
			$audio_btn.play()
			get_tree().paused = true


func _loading_out():
	$Menu/Resume.disabled = true
	$Menu/Quit.disabled = true
	$AnimationPlayer.play("loading_out")


func _on_Resume_pressed():
	$audio_btn.play()
	action = "resume"
	visible = false
	get_tree().paused = false


func _on_Quit_pressed():
	$audio_btn.play()
	action = "quit"
	_loading_out()


func _on_AnimationPlayer_animation_finished(anim_name):
	if action == "quit":
		get_tree().change_scene("res://assets/interfaces/main_menu.tscn")


func _on_Resume_focus_entered():
	if visible == true:
		$audio_select.play()


func _on_Quit_focus_entered():
	$audio_select.play()
