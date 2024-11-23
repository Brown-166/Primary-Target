extends CanvasLayer

onready var fase = get_parent().name
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	visible = true
	
	$Idle_control/keyboard.visible = true
	$Idle_control/controller.visible = false
	$Katana_control/keyboard.visible = true
	$Katana_control/controller.visible = false
	$Hammer_control/keyboard.visible = true
	$Hammer_control/controller.visible = false
	$Katar_control/keyboard.visible = true
	$Katar_control/controller.visible = false
	
	$Button_change_controller.visible = true
	$Button_change_keyboard.visible = false
	$Button_back.visible = false
	
	
	if fase == "Fase_1":
		$Idle_control.visible = true
		$Katana_control.visible = false
		$Hammer_control.visible = false
		$Katar_control.visible = false
		$Button_next.visible = true
		$Button_quit.visible = false
		$Button_next.grab_focus()
	elif fase == "Fase_2":
		$Idle_control.visible = false
		$Katana_control.visible = false
		$Hammer_control.visible = true
		$Katar_control.visible = false
		$Button_next.visible = false
		$Button_quit.visible = true
		$Button_quit.grab_focus()
	elif fase == "Fase_6":
		$Idle_control.visible = false
		$Katana_control.visible = false
		$Hammer_control.visible = false
		$Katar_control.visible = true
		$Button_next.visible = false
		$Button_quit.visible = true
		$Button_quit.grab_focus()




func _physics_process(delta):
	if fase == "Fase_1":
		if $Idle_control.visible == true:
			if $Idle_control/keyboard.visible == true:
				$Button_change_controller.focus_neighbour_bottom = $Button_next.get_path()
				$Button_next.focus_neighbour_top = $Button_change_controller.get_path()
			elif $Idle_control/controller.visible == true:
				$Button_change_keyboard.focus_neighbour_bottom = $Button_next.get_path()
				$Button_next.focus_neighbour_top = $Button_change_keyboard.get_path()
		elif $Katana_control.visible == true:
			if $Katana_control/keyboard.visible == true:
				$Button_change_controller.focus_neighbour_bottom = $Button_quit.get_path()
				$Button_quit.focus_neighbour_top = $Button_change_controller.get_path()
				$Button_quit.focus_neighbour_left = $Button_back.get_path()
				$Button_back.focus_neighbour_right = $Button_quit.get_path()
				$Button_back.focus_neighbour_top = $Button_change_controller.get_path()
			elif $Katana_control/controller.visible == true:
				$Button_change_keyboard.focus_neighbour_bottom = $Button_back.get_path()
				$Button_quit.focus_neighbour_left = $Button_back.get_path()
				$Button_quit.focus_neighbour_top = $Button_change_keyboard.get_path()
				$Button_back.focus_neighbour_right = $Button_quit.get_path()
				$Button_back.focus_neighbour_top = $Button_change_keyboard.get_path()
	else:
		if $Hammer_control/keyboard.visible == true || $Katar_control/keyboard.visible == true:
			$Button_change_controller.focus_neighbour_bottom = $Button_quit.get_path()
			$Button_quit.focus_neighbour_top = $Button_change_controller.get_path()
		elif $Hammer_control/controller.visible == true || $Katar_control/controller.visible == true:
			$Button_change_keyboard.focus_neighbour_bottom = $Button_quit.get_path()
			$Button_change_keyboard.focus_neighbour_right = $Button_quit.get_path()
			$Button_quit.focus_neighbour_top = $Button_change_keyboard.get_path()
			$Button_quit.focus_neighbour_left = $Button_change_keyboard.get_path()




func _on_Button_quit_pressed():
	$audio_btn.play()
	visible = false
	get_tree().paused = false


func _on_Button_next_pressed():
	$audio_btn.play()
	$Idle_control.visible = false
	$Katana_control.visible = true
	$Button_next.visible = false
	$Button_quit.visible = true
	$Button_back.visible = true
	$Button_quit.grab_focus()


func _on_Button_change_controller_pressed():
	$audio_btn.play()
	$Idle_control/keyboard.visible = false
	$Idle_control/controller.visible = true
	$Katana_control/keyboard.visible = false
	$Katana_control/controller.visible = true
	$Hammer_control/keyboard.visible = false
	$Hammer_control/controller.visible = true
	$Katar_control/keyboard.visible = false
	$Katar_control/controller.visible = true
	
	$Button_change_controller.visible = false
	$Button_change_keyboard.visible = true
	$Button_change_keyboard.grab_focus()


func _on_Button_change_keyboard_pressed():
	$audio_btn.play()
	$Idle_control/keyboard.visible = true
	$Idle_control/controller.visible = false
	$Katana_control/keyboard.visible = true
	$Katana_control/controller.visible = false
	$Hammer_control/keyboard.visible = true
	$Hammer_control/controller.visible = false
	$Katar_control/keyboard.visible = true
	$Katar_control/controller.visible = false
	
	$Button_change_controller.visible = true
	$Button_change_keyboard.visible = false
	$Button_change_controller.grab_focus()


func _on_Button_back_pressed():
	$audio_btn.play()
	$Idle_control.visible = true
	$Katana_control.visible = false
	$Button_next.visible = true
	$Button_back.visible = false
	$Button_quit.visible = false
	$Button_next.grab_focus()


func _on_Button_change_controller_focus_entered():
	$audio_select.play()


func _on_Button_change_keyboard_focus_entered():
	$audio_select.play()


func _on_Button_next_focus_entered():
	$audio_select.play()


func _on_Button_back_focus_entered():
	$audio_select.play()


func _on_Button_quit_focus_entered():
	$audio_select.play()


func _on_Button_change_controller_mouse_entered():
	$Button_change_controller.grab_focus()


func _on_Button_change_keyboard_mouse_entered():
	$Button_change_keyboard.grab_focus()


func _on_Button_next_mouse_entered():
	$Button_next.grab_focus()


func _on_Button_back_mouse_entered():
	$Button_back.grab_focus()


func _on_Button_quit_mouse_entered():
	$Button_quit.grab_focus()
