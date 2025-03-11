extends Node

var life = 100
var stamina = 100
var fase
var playerPosition = Vector2.ZERO
var medKit = 1

var hit = ""

var block
var dodge
var staggered = false
var flip = false
var blocked = false
var dead = false

var katana = false
var katana_DMG = 35

var hammer = false
var hammer_DMG = 60

var katar = false
var katar_DMG = 20


var weapon = "katana"

var arsenal = ["katana", "", ""]


var motorcycle_speed





var menu_theme : Theme = load("res://assets/themes/main_menu_btn.tres")
var pause_theme : Theme = load("res://assets/themes/pause_menu_btn.tres")
var label_theme : Theme = load("res://assets/themes/label.tres")

var chineseFontLabel : DynamicFont = DynamicFont.new()
var chineseFontButton : DynamicFont = DynamicFont.new()

var defaulFontLabel : DynamicFont = DynamicFont.new()
var defaulFontButton : DynamicFont = DynamicFont.new()


func _ready():
	chineseFontLabel.font_data = load("res://assets/fonts/chinese/static/NotoSansTC-Regular.ttf")
	chineseFontLabel.size = 30
	
	chineseFontButton.font_data = load("res://assets/fonts/chinese/static/NotoSansTC-Regular.ttf")
	chineseFontButton.size = 30
	
	defaulFontLabel.font_data = load("res://assets/fonts/VCR_OSD_MONO_1.001.ttf")
	defaulFontLabel.size = 40
	defaulFontLabel.outline_size = 1
	
	defaulFontButton.font_data = load("res://assets/fonts/VCR_OSD_MONO_1.001.ttf")
	defaulFontButton.size = 30
	defaulFontButton.outline_size = 1
	defaulFontButton.outline_color = "#1b1c00"


func _physics_process(delta):
	if life < 0:
		life = 0
	if life > 100:
		life = 100
	
	if stamina < 0:
		stamina = 0
	if stamina > 100:
		stamina = 100
	
	if DB.language == "chinese":
		menu_theme.set_font("font", "Button", chineseFontButton)
		pause_theme.set_font("font", "Button", chineseFontButton)
		label_theme.set_font("font", "Label", chineseFontLabel)
	else:
		menu_theme.set_font("font", "Button", defaulFontButton)
		pause_theme.set_font("font", "Button", defaulFontButton)
		label_theme.set_font("font", "Label", defaulFontLabel)


func _hit(life, area):
	match area:
		"Area2D_Katana":
			life -= katana_DMG
		"Area2D_Hammer":
			life -= hammer_DMG
		"Area2D_Hammer_stagger":
			life -= hammer_DMG/3
		"Area2D_Katar":
			life -= katar_DMG
	return life


