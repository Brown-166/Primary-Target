extends KinematicBody2D

var E_TYPE = ["rifle", "pistol"]
export var enemy_type : String = "random"

var enemy = Enemy.new(0, 0, [0], [1, 2, 3, 4, 5, 6, 7], [1, 2], [1, 2, 3, 4], [1,2,3], 
[1, 2, 3, 4, 5])
var S : Array


const BULLET = preload("res://assets/objects/AR_bullet.tscn")


onready var weapon = [$Body/Chest/R_Arm/R_Forearm/R_Hand/weapon, 
$Body/Chest/R_Arm/R_Forearm/R_Hand/weapon/reloader]






func _ready():
	if enemy_type == "random":
		randomize()
		enemy_type = E_TYPE[randi() % E_TYPE.size()]
	
	match enemy_type:
		"rifle":
			enemy.life = 100
			enemy.max_ammo = 40
			randomize()
			S = [100, 100, 125, 125, 150, 150, 175, 175, 185]
			enemy.speed = S[randi() % S.size()]
			$Area2D_Follow/Collision_Rifle.disabled = false
			$Area2D_Stop/Collision_Rifle.disabled = false
			$Area2D_Follow/Collision_Pistol.disabled = true
			$Area2D_Stop/Collision_Pistol.disabled = true
		"pistol":
			enemy.life = 75
			enemy.max_ammo = 12
			randomize()
			S = [165, 165, 175, 175, 185, 185, 190, 190, 195]
			enemy.speed = S[randi() % S.size()]
			$Area2D_Follow/Collision_Rifle.disabled = true
			$Area2D_Stop/Collision_Rifle.disabled = true
			$Area2D_Follow/Collision_Pistol.disabled = false
			$Area2D_Stop/Collision_Pistol.disabled = false
	
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
		6:
			for i in enemy.body_parts.size():
				if enemy.body_parts[i].get_class() == "AnimatedSprite":
					enemy.body_parts[i].play("option_6")
		7:
			for i in enemy.body_parts.size():
				if enemy.body_parts[i].get_class() == "AnimatedSprite":
					enemy.body_parts[i].play("option_7")
	
	for i in enemy.body_parts.size():
		if enemy.body_parts[i].name in ["Head_DMG", "Chest_DMG", "R_Arm_DMG", 
		"R_Forearm_DMG","L_Arm_DMG", "L_Forearm_DMG", "R_Thigh_DMG", "R_Leg_DMG", 
		"L_Thigh_DMG", "L_Leg_DMG"]:
			enemy.body_parts[i].play("default")
	
	match enemy_type:
		"rifle":
			match enemy.weapon_option:
				1:
					weapon[0].play("AK-47")
					weapon[1].play("AK-47")
				2:
					weapon[0].play("M-16")
					weapon[1].play("M-16")
		"pistol":
			match enemy.weapon_option:
				1:
					weapon[0].play("Colt")
					weapon[1].play("Colt")
				2:
					weapon[0].play("Glock")
					weapon[1].play("Glock")
	


func _physics_process(delta):
	enemy._physics(delta, self, $Area2D_Ground_0, $Area2D_Ground_1, $RayCasts/Right, 
	$RayCasts/Left, $RayCasts/Up, $RayCasts/Down)
	enemy._flip($Body)
	match enemy_type:
		"rifle":
			enemy._set_animation($Body/Animation_Lower, $Body/Animation_Upper, 
			$Body/Animation_Full, $audio_walk, "rifle_idle",
			"rifle_aim", "rifle_attack", "rifle_reload", "rifle_staggered")
		"pistol":
			enemy._set_animation($Body/Animation_Lower, $Body/Animation_Upper, 
			$Body/Animation_Full, $audio_walk, "pistol_idle",
			"pistol_aim", "pistol_attack", "pistol_reload", "pistol_staggered")
	
	if not enemy.action == "attack":
		$audio_shoot.stop()
	if not enemy.action == "reload":
		$audio_reload.stop()





func _on_Area2D_Enemy_AR_area_entered(area):
	enemy._take_dmg(area, $audio_cut_dmg_1, $audio_cut_dmg_2, $audio_smash_dmg_1, 
	$audio_dmg_1, $audio_dmg_2, $audio_dmg_3, $audio_dmg_4)
	if area.name in ["Area2D_Katana", "Area2D_Hammer", "Area2D_Hammer_stagger", 
	"Area2D_Katar"]:
		if enemy.layer[0] in LAYER.playerLayer || enemy.layer[1] in LAYER.playerLayer:
			enemy.action = "flee"
	if enemy.life <= 0:
		match enemy_type:
			"rifle":
				enemy._dead($Body/Animation_Full, $Area2D_Ground_0/CollisionShape2D, self, 
				$Area2D_Enemy_AR, "rifle_dead_1", "rifle_dead_2", "rifle_dead_3",
				"rifle_dead_staggered")
			"pistol":
				enemy._dead($Body/Animation_Full, $Area2D_Ground_0/CollisionShape2D, self, 
				$Area2D_Enemy_AR, "pistol_dead_1", "pistol_dead_2", "pistol_dead_3",
				"pistol_dead_staggered")


func _on_Area2D_Follow_body_entered(body):
	enemy._follow(body)


func _on_Area2D_Follow_body_exited(body):
	enemy._follow(body)


func _on_Area2D_Stop_body_entered(body):
	enemy._stop(body)


func _on_Area2D_Stop_body_exited(body):
	enemy._stop(body)


func _on_Animation_Full_animation_finished(anim_name):
	if anim_name in ["rifle_staggered", "pistol_staggered"]:
		enemy._animation_over("staggered")


func _on_Animation_Upper_animation_finished(anim_name):
	if anim_name in ["rifle_idle", "pistol_idle"]:
		enemy._animation_over("idle")
	if anim_name in ["rifle_aim", "pistol_aim"]:
		enemy._animation_over("aim")
	if anim_name in ["rifle_reload", "pistol_reload"]:
		enemy._animation_over("reload")
	if anim_name in ["rifle_attack", "pistol_attack"]:
		enemy._animation_over("attack")
		$audio_shoot.play()
		var bulletInstance = BULLET.instance()
		bulletInstance._set_layer(enemy.layer)
		get_parent().add_child(bulletInstance)
		bulletInstance.position = $PositionRight.global_position
		if enemy.flip == false:
			bulletInstance._set_direction(1)
		else:
			bulletInstance._set_direction(-1)


func _on_Animation_Lower_animation_finished(anim_name):
	enemy._animation_over(anim_name)
