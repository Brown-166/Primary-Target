extends Control

var action
var game_file = File.new()




func _ready():
	get_tree().paused = false
	DB._load_DB()
	action = ""
	$Screen_Menu/Button_Continue.disabled = false
	$Screen_Menu/Button_New_Game.disabled = false
	$Screen_Menu/Button_Load_Game.disabled = false
	$Screen_Menu/Button_Credits.disabled = false
	$Screen_Menu/Button_Quit.disabled = false
	$Screen_Saves/Button_Save_1.disabled = false
	$Screen_Saves/Button_Save_2.disabled = false
	$Screen_Saves/Button_Save_3.disabled = false
	$Screen_Saves/Button_Back.disabled = false
	$Screen_Menu.visible = true
	$Screen_Saves.visible = false
	if not game_file.file_exists("./save_files/game_1.save") && not game_file.file_exists("./save_files/game_2.save") && not game_file.file_exists("./save_files/game_3.save"):
		$Screen_Menu/Button_Continue.visible = false
		$Screen_Menu/Button_Load_Game.visible = false
		$Screen_Menu/Button_New_Game.grab_focus()
	elif DB.current_save != "":
		$Screen_Menu/Button_Continue.visible = true
		$Screen_Menu/Button_Load_Game.visible = true
		$Screen_Menu/Button_Continue.grab_focus()
	


func _physics_process(delta):
	if DB._load_game("game_1") == false:
		$Screen_Saves/Button_Save_1.text = "VAZIO"
	else:
		$Screen_Saves/Button_Save_1.text = "SAVE 1"
	
	if DB._load_game("game_2") == false:
		$Screen_Saves/Button_Save_2.text = "VAZIO"
	else:
		$Screen_Saves/Button_Save_2.text = "SAVE 2"
	
	if DB._load_game("game_3") == false:
		$Screen_Saves/Button_Save_3.text = "VAZIO"
	else:
		$Screen_Saves/Button_Save_3.text = "SAVE 3"


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
	action = "continue"
	DB._load_game(DB.current_save)
	_loading_out()


func _on_Button_New_Game_pressed():
	$Screen_Menu.visible = false
	$Screen_Saves.visible = true
	$Screen_Saves/Button_Save_1.grab_focus()
	action = "new game"


func _on_Button_Load_Game_pressed():
	$Screen_Menu.visible = false
	$Screen_Saves.visible = true
	$Screen_Saves/Button_Save_1.grab_focus()
	action = "load game"


func _on_Button_Credits_pressed():
	action = "credits"
	_loading_out()


func _on_Button_Quit_pressed():
	get_tree().quit()



func _on_Button_Save_1_pressed():
	DB.current_save = "game_1"
	DB._save_DB()
	if action == "new game":
		Global.life = 100
		Global.stamina = 100
		Global.medKit = 0
		Global.fase = "cutscene_1"
		DB._save_new_game(DB.current_save)
		_loading_out()
	if action == "load game":
		if game_file.file_exists("./save_files/game_1.save"):
			DB._load_game(DB.current_save)
			_loading_out()


func _on_Button_Save_2_pressed():
	DB.current_save = "game_2"
	DB._save_DB()
	if action == "new game":
		Global.life = 100
		Global.stamina = 100
		Global.medKit = 0
		Global.fase = "cutscene_1"
		DB._save_new_game(DB.current_save)
		_loading_out()
	if action == "load game":
		if game_file.file_exists("./save_files/game_2.save"):
			DB._load_game(DB.current_save)
			_loading_out()


func _on_Button_Save_3_pressed():
	DB.current_save = "game_3"
	DB._save_DB()
	if action == "new game":
		Global.life = 100
		Global.stamina = 100
		Global.medKit = 0
		Global.fase = "cutscene_1"
		DB._save_new_game(DB.current_save)
		_loading_out()
	if action == "load game":
		if game_file.file_exists("./save_files/game_3.save"):
			DB._load_game(DB.current_save)
			_loading_out()


func _on_Button_Back_pressed():
	$Screen_Menu.visible = true
	$Screen_Saves.visible = false
	if not game_file.file_exists("./save_files/game_1.save") && not game_file.file_exists("./save_files/game_2.save") && not game_file.file_exists("./save_files/game_3.save"):
		$Screen_Menu/Button_Continue.visible = false
		$Screen_Menu/Button_Load_Game.visible = false
		$Screen_Menu/Button_New_Game.grab_focus()
	elif DB.current_save != "":
		$Screen_Menu/Button_Continue.visible = true
		$Screen_Menu/Button_Load_Game.visible = true
		$Screen_Menu/Button_Continue.grab_focus()


func _on_AnimationPlayer_animation_finished(anim_name):
	if action == "continue" || action == "new game" || action == "load game":
		if Global.fase in ["cutscene_1"]:
			get_tree().change_scene("res://assets/cutscenes/"+ Global.fase +".tscn")
		else:
			get_tree().change_scene("res://assets/scenes/"+ Global.fase +".tscn")
	if action == "credits":
		get_tree().change_scene("res://assets/interfaces/credits.tscn")
