extends KinematicBody2D

var E_TYPE = ["knife"]
export var enemy_type : String = "random"

var enemy = Enemy.new(0, 0, [0], [1, 2, 3, 4, 5], [1, 2], [1, 2, 3, 4], [1,2,3], 
[1, 2, 3, 4, 5])
var S : Array

var blocked = false

onready var weapon = [$Body/Chest/R_Arm/R_Forearm/R_Hand/weapon]

var area_player = false

var ST = [3, 4, 4, 5]


func _ready():
	if enemy_type == "random":
		randomize()
		enemy_type = E_TYPE[randi() % E_TYPE.size()]
	
	match enemy_type:
		"knife":
			enemy.life = 150
			randomize()
			enemy.max_ammo = ST[randi() % ST.size()]
			enemy.speed = 150
	
	enemy.ammo = enemy.max_ammo
	
	enemy._set_body($Body)
	match enemy.option:
		1:
			for i in enemy.body_parts.size():
				if enemy.body_parts[i].get_class() == "AnimatedSprite":
					enemy.body_parts[i].play("option_1")
		2:
			for i in enemy.body_parts.size():
				if enemy.body_parts[i].get_class() == "AnimatedSprite":
					enemy.body_parts[i].play("option_2")
		3:
			for i in enemy.body_parts.size():
				if enemy.body_parts[i].get_class() == "AnimatedSprite":
					enemy.body_parts[i].play("option_3")
		4:
			for i in enemy.body_parts.size():
				if enemy.body_parts[i].get_class() == "AnimatedSprite":
					enemy.body_parts[i].play("option_4")
		5:
			for i in enemy.body_parts.size():
				if enemy.body_parts[i].get_class() == "AnimatedSprite":
					enemy.body_parts[i].play("option_5")
	
	for i in enemy.body_parts.size():
		if enemy.body_parts[i].name in ["Head_DMG", "Chest_DMG", "R_Arm_DMG", 
		"R_Forearm_DMG","L_Arm_DMG", "L_Forearm_DMG", "R_Thigh_DMG", "R_Leg_DMG", 
		"L_Thigh_DMG", "L_Leg_DMG"]:
			enemy.body_parts[i].play("default")
	
	match enemy_type:
		"knife":
			match enemy.weapon_option:
				1:
					weapon[0].play("knife_1")
				2:
					weapon[0].play("knife_2")


func _physics_process(delta):
	enemy._physics(delta, self, $Area2D_Ground_0, $Area2D_Ground_1, $RayCasts/Right, 
	$RayCasts/Left, $RayCasts/Up, $RayCasts/Down)
	enemy._flip($Body)
	match enemy_type:
		"knife":
			enemy._set_animation($Body/Animation_Lower, $Body/Animation_Upper, 
			$Body/Animation_Full, $audio_walk, "knife_idle", "", "knife_attack_1", 
			"knife_attack_2", "knife_recharge", "knife_staggered")
	
	for body in $Area2D_Stop.get_overlapping_bodies():
		if body.name == "Player":
			area_player = true
			if enemy.action == "follow":
				enemy.action = "attack"
			elif enemy.action == "attack":
				if enemy.ammo > 0:
					enemy.action = "attack"
				else:
					enemy.action = "flee"




func _on_Area2D_Enemy_Short_Range_area_entered(area):
	enemy._take_dmg(area, $audio_cut_dmg_1, $audio_cut_dmg_2, $audio_smash_dmg_1, 
	$audio_dmg_1, $audio_dmg_2, $audio_dmg_3, $audio_dmg_4)
	if area.name in ["Area2D_Katana", "Area2D_Hammer", "Area2D_Hammer_stagger", 
	"Area2D_Katar"]:
		if enemy.layer[0] in LAYER.playerLayer || enemy.layer[1] in LAYER.playerLayer:
			if enemy.action == "reload":
				enemy.action = "flee"
	if enemy.life <= 0:
		match enemy_type:
			"knife":
				enemy._dead($Body/Animation_Full, $Area2D_Ground_0/CollisionShape2D, self, 
				$Area2D_Enemy_Short_Range, "knife_dead_1", "knife_dead_2", "knife_dead_3",
				"knife_dead_staggered")


func _on_Area2D_Follow_body_entered(body):
	enemy._follow(body)


func _on_Area2D_Follow_body_exited(body):
	enemy._follow(body)


func _on_Area2D_Stop_body_entered(body):
	pass


func _on_Area2D_Stop_body_exited(body):
	if enemy.ammo > 0:
		area_player = false


func _on_Area2D_Flee_body_exited(body):
	if enemy.action == "flee":
		if enemy.ammo < enemy.max_ammo:
			enemy.action = "reload"
		else:
			enemy._follow(body)


func _on_Animation_Full_animation_finished(anim_name):
	if anim_name in ["knife_staggered"]:
		enemy._animation_over("staggered")


func _on_Animation_Upper_animation_finished(anim_name):
	if enemy.target:
		if area_player == false:
			if enemy.ammo > 0:
				enemy._follow(enemy.target)
	if anim_name in ["knife_idle"]:
		enemy._animation_over("idle")
	if anim_name in ["knife_recharge"]:
		if enemy.ammo < enemy.max_ammo:
			enemy.ammo += 1
			if enemy.ammo == enemy.max_ammo:
				enemy.action = "follow"
	if anim_name in ["knife_attack_1", "knife_attack_2"]:
		enemy.ammo -= 1


func _on_Animation_Lower_animation_finished(anim_name):
	enemy._animation_over(anim_name)


func _on_Area2D_weapon_area_entered(area):
	if enemy.life > 0:
		if enemy.layer[0] in LAYER.playerLayer || enemy.layer[1] in LAYER.playerLayer:
			if enemy.staggered == false:
				if area.name in ["Area2D_Player"]:
					if Global.block == true && Global.flip != enemy.flip:
						if Global.stamina >= 10:
							Global.blocked = true
							Global.stamina -= 10
						else:
							Global.life -= 5
							Global.stamina -= 10
							Global.hit = "attack"
					else:
						if Global.dodge == false:
							Global.life -= 5
							Global.hit = "attack"
