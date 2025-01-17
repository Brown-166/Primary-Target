extends Control

var action
var game_file = File.new()
var skip = false



func _ready():
	get_tree().paused = false
	DB._load_DB()
	action = ""
	$audio_menu.play()
	$Screen_Menu/Button_Continue.disabled = false
	$Screen_Menu/Button_New_Game.disabled = false
	$Screen_Menu/Button_Load_Game.disabled = false
	$Screen_Menu/Button_Credits.disabled = false
	$Screen_Menu/Button_Quit.disabled = false
	$Screen_Saves/Button_Save_1.disabled = false
	$Screen_Saves/Button_Save_2.disabled = false
	$Screen_Saves/Button_Save_3.disabled = false
	$Screen_Saves/Button_Back.disabled = false
	$Screen_Saves/Button_Delete_1.visible = false
	$Screen_Saves/Button_Delete_2.visible = false
	$Screen_Saves/Button_Delete_3.visible = false
	$Screen_Menu.visible = true
	$Screen_Saves.visible = false
	$Screen_new_game.visible = false
	if not game_file.file_exists(DB.con_string + "game_1.save") && not game_file.file_exists(DB.con_string + "game_2.save") && not game_file.file_exists(DB.con_string + "game_3.save"):
		$Screen_Menu/Button_Continue.visible = false
		$Screen_Menu/Button_Load_Game.visible = false
		$Screen_Menu/Button_New_Game.grab_focus()
	elif DB.current_save != "":
		$Screen_Menu/Button_Continue.visible = true
		$Screen_Menu/Button_Load_Game.visible = true
		$Screen_Menu/Button_Continue.grab_focus()
	
	
	
	$Screen_new_game/Skip_button.visible = false
	$Screen_new_game/Skip_button.value = 0.1
	
	
	match DB.language:
		"portuguese":
			$Screen_Menu/Button_Continue.text = "CONTINUAR"
			$Screen_Menu/Button_New_Game.text = "NOVO JOGO"
			$Screen_Menu/Button_Load_Game.text = "CARREGAR JOGO"
			$Screen_Menu/Button_Credits.text = "CRÉDITOS"
			$Screen_Menu/Button_Quit.text = "SAIR"
			$Screen_Menu/Button_Language.text = "IDIOMA"
			$Screen_Saves/Button_Back.text = "VOLTAR"
			$Screen_new_game/target_description.text = """Novo contrato selecionado
			Tipo de contrato: Assassinato
			Contratante: Anônimo
			Dificuldade: Médio
			Recompença: R$500.000,00
			
			Alvo principal: Hades
			Nome real: Frederico Hard
			Ocupação: Comandante da máfia de São Paulo
			Situação atual: Fazendo negócios na cidade"""
			$Screen_new_game/Label_good_hunt.text = "Tenha uma boa caçada"
		"english":
			$Screen_Menu/Button_Continue.text = "CONTINUE"
			$Screen_Menu/Button_New_Game.text = "NEW GAME"
			$Screen_Menu/Button_Load_Game.text = "LOAD GAME"
			$Screen_Menu/Button_Credits.text = "CREDITS"
			$Screen_Menu/Button_Quit.text = "QUIT"
			$Screen_Menu/Button_Language.text = "LANGUAGE"
			$Screen_Saves/Button_Back.text = "BACK"
			$Screen_new_game/target_description.text = """New contract selected
			Type of contract: Assassination
			Contractor: Anonymous
			Dificulty: Medium
			Reward: $85.000,00
			
			Primary target: Hades
			Real name: Frederico Hard
			Ocupation: Commander of the Sao Paulo mafia
			Current status: Doing business in the city"""
			$Screen_new_game/Label_good_hunt.text = "Have a good hunt"
		"spanish":
			$Screen_Menu/Button_Continue.text = "CONTINUAR"
			$Screen_Menu/Button_New_Game.text = "NUEVO JUEGO"
			$Screen_Menu/Button_Load_Game.text = "CARGAR JUEGO"
			$Screen_Menu/Button_Credits.text = "CRÉDITOS"
			$Screen_Menu/Button_Quit.text = "SALIR"
			$Screen_Menu/Button_Language.text = "IDIOMA"
			$Screen_Saves/Button_Back.text = "VOLVER"
			$Screen_new_game/target_description.text = """Nuevo contrato seleccionado
			Tipo de contrato: Asesinato
			Contratista: Anónimo
			Dificultad: Medio
			Recompensa: € 80.000,00
			
			Objetivo principal: Hades
			Nombre real: Federico Hard
			Ocupación: Comandante de la mafia de Sao Paulo
			Situación actual: Hacer negocios en la ciudad"""
			$Screen_new_game/Label_good_hunt.text = "Que tengas una buena cacería"




func _physics_process(delta):
	if DB._load_game("game_1") == false:
		match DB.language:
			"portuguese":
				$Screen_Saves/Button_Save_1.text = "VAZIO"
			"english":
				$Screen_Saves/Button_Save_1.text = "EMPTY"
			"spanish":
				$Screen_Saves/Button_Save_1.text = "VACÍO"
	else:
		$Screen_Saves/Button_Save_1.text = "SAVE 1"
	
	if DB._load_game("game_2") == false:
		match DB.language:
			"portuguese":
				$Screen_Saves/Button_Save_2.text = "VAZIO"
			"english":
				$Screen_Saves/Button_Save_2.text = "EMPTY"
			"spanish":
				$Screen_Saves/Button_Save_2.text = "VACÍO"
	else:
		$Screen_Saves/Button_Save_2.text = "SAVE 2"
	
	if DB._load_game("game_3") == false:
		match DB.language:
			"portuguese":
				$Screen_Saves/Button_Save_3.text = "VAZIO"
			"english":
				$Screen_Saves/Button_Save_3.text = "EMPTY"
			"spanish":
				$Screen_Saves/Button_Save_3.text = "VACÍO"
	else:
		$Screen_Saves/Button_Save_3.text = "SAVE 3"
	
	
	
	if $AnimationPlayer.current_animation == "new_game":
		if skip == false:
			if Input.is_action_pressed("space"):
				$Screen_new_game/Skip_button.value *= 1.1
			else:
				if $Screen_new_game/Skip_button.value > 0.1:
					$Screen_new_game/Skip_button.value /= 1.1
			
			if $Screen_new_game/Skip_button.value < 0.1:
				$Screen_new_game/Skip_button.value = 0.1
			
			if $Screen_new_game/Skip_button.value == 0.1:
				$Screen_new_game/Skip_button.visible = false
			else:
				$Screen_new_game/Skip_button.visible = true
			
			if $Screen_new_game/Skip_button.value == 100:
				skip = true
				$AnimationPlayer.play("loading_out")
	
	
	if $Screen_Saves.visible == true:
		if $Screen_Saves.get_focus_owner().name in ["Button_Save_1", "Button_Delete_1"]:
			if game_file.file_exists(DB.con_string + "game_1.save"):
				$Screen_Saves/Button_Delete_1.visible = true
		else:
			$Screen_Saves/Button_Delete_1.visible = false
		
		if $Screen_Saves.get_focus_owner().name in ["Button_Save_2", "Button_Delete_2"]:
			if game_file.file_exists(DB.con_string + "game_2.save"):
				$Screen_Saves/Button_Delete_2.visible = true
		else:
			$Screen_Saves/Button_Delete_2.visible = false
		
		if $Screen_Saves.get_focus_owner().name in ["Button_Save_3", "Button_Delete_3"]:
			if game_file.file_exists(DB.con_string + "game_3.save"):
				$Screen_Saves/Button_Delete_3.visible = true
		else:
			$Screen_Saves/Button_Delete_3.visible = false


func _loading_out():
	$Screen_Menu/Button_Continue.disabled = true
	$Screen_Menu/Button_New_Game.disabled = true
	$Screen_Menu/Button_Load_Game.disabled = true
	$Screen_Menu/Button_Credits.disabled = true
	$Screen_Menu/Button_Quit.disabled = true
	$Screen_Saves/Button_Save_1.disabled = true
	$Screen_Saves/Button_Save_2.disabled = true
	$Screen_Saves/Button_Save_3.disabled = true
	$Screen_Saves/Button_Back.disabled = true
	if action == "new game":
		$AnimationPlayer.play("new_game")
	else:
		$AnimationPlayer.play("loading_out")


func _on_Button_Continue_pressed():
	$audio_btn.play()
	action = "continue"
	DB._load_game(DB.current_save)
	_loading_out()


func _on_Button_New_Game_pressed():
	$audio_btn.play()
	$Screen_Menu.visible = false
	$Screen_Saves.visible = true
	$Screen_Saves/Button_Save_1.grab_focus()
	action = "new game"


func _on_Button_Load_Game_pressed():
	$audio_btn.play()
	$Screen_Menu.visible = false
	$Screen_Saves.visible = true
	$Screen_Saves/Button_Save_1.grab_focus()
	action = "load game"


func _on_Button_Credits_pressed():
	$audio_btn.play()
	action = "credits"
	_loading_out()


func _on_Button_Quit_pressed():
	$audio_btn.play()
	get_tree().quit()



func _on_Button_Save_1_pressed():
	$audio_btn.play()
	DB.current_save = "game_1"
	DB._save_DB()
	if action == "new game":
		Global.life = 100
		Global.stamina = 100
		Global.medKit = 1
		Global.fase = "cutscene_1"
		Global.weapon = "katana"
		Global.arsenal = ["katana", "", ""]
		Global.trys = 3
		DB._save_new_game(DB.current_save)
		_loading_out()
	if action == "load game":
		if game_file.file_exists(DB.con_string + "game_1.save"):
			DB._load_game(DB.current_save)
			_loading_out()


func _on_Button_Save_2_pressed():
	$audio_btn.play()
	DB.current_save = "game_2"
	DB._save_DB()
	if action == "new game":
		Global.life = 100
		Global.stamina = 100
		Global.medKit = 1
		Global.fase = "cutscene_1"
		Global.weapon = "katana"
		Global.arsenal = ["katana", "", ""]
		Global.trys = 3
		DB._save_new_game(DB.current_save)
		_loading_out()
	if action == "load game":
		if game_file.file_exists(DB.con_string + "game_2.save"):
			DB._load_game(DB.current_save)
			_loading_out()


func _on_Button_Save_3_pressed():
	$audio_btn.play()
	DB.current_save = "game_3"
	DB._save_DB()
	if action == "new game":
		Global.life = 100
		Global.stamina = 100
		Global.medKit = 1
		Global.fase = "cutscene_1"
		Global.weapon = "katana"
		Global.arsenal = ["katana", "", ""]
		Global.trys = 3
		DB._save_new_game(DB.current_save)
		_loading_out()
	if action == "load game":
		if game_file.file_exists(DB.con_string + "game_3.save"):
			DB._load_game(DB.current_save)
			_loading_out()


func _on_Button_Back_pressed():
	$audio_btn.play()
	$Screen_Menu.visible = true
	$Screen_Saves.visible = false
	if not game_file.file_exists(DB.con_string + "game_1.save") && not game_file.file_exists(DB.con_string + "game_2.save") && not game_file.file_exists(DB.con_string + "game_3.save"):
		$Screen_Menu/Button_Continue.visible = false
		$Screen_Menu/Button_Load_Game.visible = false
		$Screen_Menu/Button_New_Game.grab_focus()
	elif DB.current_save != "":
		$Screen_Menu/Button_Continue.visible = true
		$Screen_Menu/Button_Load_Game.visible = true
		$Screen_Menu/Button_Continue.grab_focus()


func _on_AnimationPlayer_animation_finished(anim_name):
	if action == "continue" || action == "new game" || action == "load game":
		if Global.fase in ["cutscene_1", "cutscene_2", "cutscene_3", "cutscene_4", "cutscene_5", "cutscene_6", "cutscene_7"]:
			get_tree().change_scene("res://assets/cutscenes/"+ Global.fase +".tscn")
		else:
			get_tree().change_scene("res://assets/scenes/"+ Global.fase +".tscn")
	if action == "credits":
		get_tree().change_scene("res://assets/interfaces/credits.tscn")
	if action == "language":
		get_tree().change_scene("res://assets/interfaces/language_select.tscn")



func _on_Button_Continue_focus_entered():
	if $AnimationPlayer.is_playing() == false:
		$audio_select.play()


func _on_Button_New_Game_focus_entered():
	if $AnimationPlayer.is_playing() == false:
		$audio_select.play()


func _on_Button_Load_Game_focus_entered():
	$audio_select.play()


func _on_Button_Credits_focus_entered():
	$audio_select.play()


func _on_Button_Quit_focus_entered():
	$audio_select.play()


func _on_Button_Save_1_focus_entered():
	$audio_select.play()


func _on_Button_Save_2_focus_entered():
	$audio_select.play()


func _on_Button_Save_3_focus_entered():
	$audio_select.play()


func _on_Button_Back_focus_entered():
	$audio_select.play()


func _on_Button_Continue_mouse_entered():
	$Screen_Menu/Button_Continue.grab_focus()


func _on_Button_New_Game_mouse_entered():
	$Screen_Menu/Button_New_Game.grab_focus()


func _on_Button_Load_Game_mouse_entered():
	$Screen_Menu/Button_Load_Game.grab_focus()


func _on_Button_Credits_mouse_entered():
	$Screen_Menu/Button_Credits.grab_focus()


func _on_Button_Quit_mouse_entered():
	$Screen_Menu/Button_Quit.grab_focus()


func _on_Button_Save_1_mouse_entered():
	$Screen_Saves/Button_Save_1.grab_focus()


func _on_Button_Save_2_mouse_entered():
	$Screen_Saves/Button_Save_2.grab_focus()


func _on_Button_Save_3_mouse_entered():
	$Screen_Saves/Button_Save_3.grab_focus()


func _on_Button_Back_mouse_entered():
	$Screen_Saves/Button_Back.grab_focus()


func _on_Button_Delete_1_pressed():
	$audio_btn.play()
	if game_file.file_exists(DB.con_string + "game_1.save"):
		var dir = Directory.new()
		dir.remove(DB.con_string + "game_1.save")


func _on_Button_Delete_2_pressed():
	$audio_btn.play()
	if game_file.file_exists(DB.con_string + "game_2.save"):
		var dir = Directory.new()
		dir.remove(DB.con_string + "game_2.save")


func _on_Button_Delete_3_pressed():
	$audio_btn.play()
	if game_file.file_exists(DB.con_string + "game_3.save"):
		var dir = Directory.new()
		dir.remove(DB.con_string + "game_3.save")


func _on_Button_Delete_1_focus_entered():
	$audio_select.play()


func _on_Button_Delete_2_focus_entered():
	$audio_select.play()


func _on_Button_Delete_3_focus_entered():
	$audio_select.play()


func _on_Button_Delete_1_mouse_entered():
	$Screen_Saves/Button_Delete_1.grab_focus()


func _on_Button_Delete_2_mouse_entered():
	$Screen_Saves/Button_Delete_2.grab_focus()


func _on_Button_Delete_3_mouse_entered():
	$Screen_Saves/Button_Delete_3.grab_focus()


func _on_Button_Language_pressed():
	$audio_btn.play()
	action = "language"
	DB.language_selected = false
	DB._save_DB()
	_loading_out()


func _on_Button_Language_mouse_entered():
	$Screen_Menu/Button_Language.grab_focus()


func _on_Button_Language_focus_entered():
	$audio_select.play()
