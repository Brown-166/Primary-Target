extends Control

var game_file = File.new()


func _ready():
	DB._load_DB()
	if DB.language_selected == true:
		get_tree().change_scene("res://assets/interfaces/main_menu.tscn")
	else:
		$portuguese.grab_focus()
		match DB.language:
			"portuguese":
				$Label.text = "SELECIONAR IDIOMA:"
			"english":
				$Label.text = "SELECT LANGUAGE:"
			"spanish":
				$Label.text = "SELECCIONE IDIOMA:"



func _on_portuguese_pressed():
	$audio_btn.play()
	DB.language = "portuguese"
	DB.language_selected = true
	DB._save_DB()
	get_tree().change_scene("res://assets/interfaces/main_menu.tscn")


func _on_portuguese_mouse_entered():
	$portuguese.grab_focus()


func _on_portuguese_focus_entered():
	$audio_select.play()


func _on_english_pressed():
	$audio_btn.play()
	DB.language = "english"
	DB.language_selected = true
	DB._save_DB()
	get_tree().change_scene("res://assets/interfaces/main_menu.tscn")


func _on_english_mouse_entered():
	$english.grab_focus()


func _on_english_focus_entered():
	$audio_select.play()


func _on_spanish_pressed():
	$audio_btn.play()
	DB.language = "spanish"
	DB.language_selected = true
	DB._save_DB()
	get_tree().change_scene("res://assets/interfaces/main_menu.tscn")

func _on_spanish_mouse_entered():
	$spanish.grab_focus()


func _on_spanish_focus_entered():
	$audio_select.play()
