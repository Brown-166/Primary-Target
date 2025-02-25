extends CanvasLayer

onready var fase = get_parent().name


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
	DB._load_DB()
	match DB.language:
		"portuguese":
			$Idle_control/keyboard/move/OR.text = "OU"
			$Idle_control/keyboard/move/Label.text = "ANDAR"
			$Idle_control/keyboard/medkit.text = "USAR CURA"
			$Idle_control/keyboard/jump.text = "PULAR"
			$Idle_control/keyboard/pause.text = "PAUSAR"
			$Idle_control/keyboard/attack.text = "ATACAR"
			
			$Idle_control/controller/move.text = "ANDAR"
			$Idle_control/controller/medkit.text = "USAR CURA"
			$Idle_control/controller/jump.text = "PULAR"
			$Idle_control/controller/pause.text = "PAUSAR"
			$Idle_control/controller/attack.text = "ATACAR"
			
			$Katana_control/keyboard/block.text = "BLOQUEAR"
			$Katana_control/keyboard/equip.text = "EQUIPAR"
			$Katana_control/controller/block.text = "BLOQUEAR"
			$Katana_control/controller/equip.text = "EQUIPAR"
			
			$Hammer_control/name.text = "Martelo"
			$Hammer_control/keyboard/equip.text = "EQUIPAR"
			$Hammer_control/keyboard/stagger.text = "DERRUBAR"
			$Hammer_control/controller/equip.text = "EQUIPAR"
			$Hammer_control/controller/stagger.text = "DERRUBAR"
			
			$Katar_control/keyboard/equip.text = "EQUIPAR"
			$Katar_control/keyboard/dodge.text = "ESQUIVAR"
			$Katar_control/controller/equip.text = "EQUIPAR"
			$Katar_control/controller/dodge.text = "ESQUIVAR"
			
			$Button_next.text = "PRÓXIMO"
			$Button_back.text = "VOLTAR"
			$Button_quit.text = "FECHAR"
		"english":
			$Idle_control/keyboard/move/OR.text = "OR"
			$Idle_control/keyboard/move/Label.text = "MOVE"
			$Idle_control/keyboard/medkit.text = "USE MEDKIT"
			$Idle_control/keyboard/jump.text = "JUMP"
			$Idle_control/keyboard/pause.text = "PAUSE"
			$Idle_control/keyboard/attack.text = "ATTACK"
			
			$Idle_control/controller/move.text = "MOVE"
			$Idle_control/controller/medkit.text = "USE MEDKIT"
			$Idle_control/controller/jump.text = "JUMP"
			$Idle_control/controller/pause.text = "PAUSE"
			$Idle_control/controller/attack.text = "ATTACK"
			
			$Katana_control/keyboard/block.text = "BLOCK"
			$Katana_control/keyboard/equip.text = "EQUIP"
			$Katana_control/controller/block.text = "BLOCK"
			$Katana_control/controller/equip.text = "EQUIP"
			
			$Hammer_control/name.text = "Hammer"
			$Hammer_control/keyboard/equip.text = "EQUIP"
			$Hammer_control/keyboard/stagger.text = "STAGGER"
			$Hammer_control/controller/equip.text = "EQUIP"
			$Hammer_control/controller/stagger.text = "STAGGER"
			
			$Katar_control/keyboard/equip.text = "EQUIP"
			$Katar_control/keyboard/dodge.text = "DODGE"
			$Katar_control/controller/equip.text = "EQUIP"
			$Katar_control/controller/dodge.text = "DODGE"
			
			$Button_next.text = "NEXT"
			$Button_back.text = "BACK"
			$Button_quit.text = "CLOSE"
		"spanish":
			$Idle_control/keyboard/move/OR.text = "O"
			$Idle_control/keyboard/move/Label.text = "CAMINAR"
			$Idle_control/keyboard/medkit.text = "UTILIZAR CURA"
			$Idle_control/keyboard/jump.text = "SALTAR"
			$Idle_control/keyboard/pause.text = "PAUSAR"
			$Idle_control/keyboard/attack.text = "ATACAR"
			
			$Idle_control/controller/move.text = "CAMINAR"
			$Idle_control/controller/medkit.text = "UTILIZAR CURA"
			$Idle_control/controller/jump.text = "SALTAR"
			$Idle_control/controller/pause.text = "PAUSAR"
			$Idle_control/controller/attack.text = "ATACAR"
			
			$Katana_control/keyboard/block.text = "BLOQUEAR"
			$Katana_control/keyboard/equip.text = "EQUIPAR"
			$Katana_control/controller/block.text = "BLOQUEAR"
			$Katana_control/controller/equip.text = "EQUIPAR"
			
			$Hammer_control/name.text = "Martillo"
			$Hammer_control/keyboard/equip.text = "EQUIPAR"
			$Hammer_control/keyboard/stagger.text = "DERRIBAR"
			$Hammer_control/controller/equip.text = "EQUIPAR"
			$Hammer_control/controller/stagger.text = "DERRIBAR"
			
			$Katar_control/keyboard/equip.text = "EQUIPAR"
			$Katar_control/keyboard/dodge.text = "ESQUIVAR"
			$Katar_control/controller/equip.text = "EQUIPAR"
			$Katar_control/controller/dodge.text = "ESQUIVAR"
			
			$Button_next.text = "PRÓXIMO"
			$Button_back.text = "VOLVER"
			$Button_quit.text = "CERRAR"
		"chinese":
			$Idle_control/keyboard/move/OR.text = "或者"
			$Idle_control/keyboard/move/Label.text = "移動"
			$Idle_control/keyboard/medkit.text = "使用醫療包"
			$Idle_control/keyboard/jump.text = "跳"
			$Idle_control/keyboard/pause.text = "暫停"
			$Idle_control/keyboard/attack.text = "攻擊"
			
			$Idle_control/controller/move.text = "移動"
			$Idle_control/controller/medkit.text = "使用醫療包"
			$Idle_control/controller/jump.text = "跳"
			$Idle_control/controller/pause.text = "暫停"
			$Idle_control/controller/attack.text = "攻擊"
			
			$Katana_control/keyboard/block.text = "堵塞"
			$Katana_control/keyboard/equip.text = "裝備"
			$Katana_control/controller/block.text = "堵塞"
			$Katana_control/controller/equip.text = "裝備"
			
			$Hammer_control/name.text = "Hammer"
			$Hammer_control/keyboard/equip.text = "裝備"
			$Hammer_control/keyboard/stagger.text = "錯開"
			$Hammer_control/controller/equip.text = "裝備"
			$Hammer_control/controller/stagger.text = "錯開"
			
			$Katar_control/keyboard/equip.text = "裝備"
			$Katar_control/keyboard/dodge.text = "閃避"
			$Katar_control/controller/equip.text = "裝備"
			$Katar_control/controller/dodge.text = "閃避"
			
			$Button_next.text = "下一個"
			$Button_back.text = "後退"
			$Button_quit.text = "關閉"
	
	
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
