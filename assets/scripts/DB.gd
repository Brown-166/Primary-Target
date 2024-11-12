extends Node

var current_save = ""





func _save_DB():
	var dic_save = {
		"current_save":current_save
	}
	var DB_file = File.new()
	DB_file.open_encrypted_with_pass("./save_files/DB.save", File.WRITE, "summer")
#	DB_file.open("./save_files/DB.save", File.WRITE)
	DB_file.store_line(to_json(dic_save))
	DB_file.close()

func _load_DB():
	var DB_file = File.new()
	if not DB_file.file_exists("./save_files/DB.save"):
		return false
	else:
		DB_file.open_encrypted_with_pass("./save_files/DB.save", File.READ, "summer")
#		DB_file.open("./save_files/DB.save", File.READ)
		var save_line = parse_json(DB_file.get_line())
		current_save = save_line["current_save"]
		DB_file.close()





func _save():
	var dic_save = {
		"life":Global.life,
		"stamina":Global.stamina,
		"medKit":Global.medKit,
		"weapon":Global.weapon,
		"fase":Global.fase,
		"arsenal":Global.arsenal
	}
	return dic_save


func _save_new_game(save):
	var game_file = File.new()
	game_file.open_encrypted_with_pass("./save_files/"+ save +".save", File.WRITE, "summer")
#	game_file.open("./save_files/"+ save +".save", File.WRITE)
	game_file.store_line(to_json(_save()))
	game_file.close()


func _load_game(save):
	var game_file = File.new()
	if not game_file.file_exists("./save_files/"+ save +".save"):
		return false
	else:
		game_file.open_encrypted_with_pass("./save_files/"+ save +".save", File.READ, "summer")
#		game_file.open("./save_files/"+ save +".save", File.READ)
		var save_line = parse_json(game_file.get_line())
		Global.life = save_line["life"]
		Global.stamina = save_line["stamina"]
		Global.medKit = save_line["medKit"]
		Global.weapon = save_line["weapon"]
		Global.fase = save_line["fase"]
		Global.arsenal = save_line["arsenal"]
		game_file.close()
