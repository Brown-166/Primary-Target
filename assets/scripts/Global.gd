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


func _ready():
	pass
func _physics_process(delta):
	
	if life < 0:
		life = 0
	if life > 100:
		life = 100
	
	if stamina < 0:
		stamina = 0
	if stamina > 100:
		stamina = 100


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


