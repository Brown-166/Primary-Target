extends CanvasLayer

onready var fase = get_parent().name
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	visible = true
	$Button_quit.grab_focus()
	if fase == "Fase_1":
		$Katana_control.visible = true
		$Hammer_control.visible = false
		$Katar_control.visible = false
	elif fase == "Fase_2":
		$Katana_control.visible = false
		$Hammer_control.visible = true
		$Katar_control.visible = false
	elif fase == "Fase_6":
		$Katana_control.visible = false
		$Hammer_control.visible = false
		$Katar_control.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_quit_pressed():
	$audio_btn.play()
	visible = false
	get_tree().paused = false
