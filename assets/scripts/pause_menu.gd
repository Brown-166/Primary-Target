extends CanvasLayer

var action
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	$ColorRect.visible = false
	$Menu/Resume.disabled = false
	$Menu/Quit.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") || event.is_action_pressed("ui_pause"):
		visible = true
		get_tree().paused = true
		$Menu/Resume.grab_focus()

func _loading_out():
	$Menu/Resume.disabled = true
	$Menu/Quit.disabled = true
	$AnimationPlayer.play("loading_out")


func _on_Resume_pressed():
	action = "resume"
	visible = false
	get_tree().paused = false


func _on_Quit_pressed():
	action = "quit"
	_loading_out()


func _on_AnimationPlayer_animation_finished(anim_name):
	if action == "quit":
		get_tree().change_scene("res://assets/interfaces/main_menu.tscn")
