extends KinematicBody2D

const S = [165, 165, 175, 175, 185, 185, 190, 190, 195]
var speed
var velocity
var stop = true
var moving = false
var flee = false

var flip = false
var OP = [1,]
var option
var WO = [1, 2]
var weapon_option
var DMG = [1, 2, 3, 4, 5, 6, 7]
var damage
var ADMG = [1, 2, 3, 4]
var audio_dmg
var audio
var DEAD = [1,2,3]
var dead = 0

var ammo = 12
var reload = false
var aim = false
var attack = false

var life = 75
var layer
var staggered = false
var target = null
const BULLET = preload("res://assets/objects/AR_bullet.tscn")

var MEDKIT = preload("res://assets/objects/medKit.tscn")
var MD = [1, 2, 3, 4, 5]
var med_drop

onready var enemy_parts = [
	$Enemy_Parts/Upper_Right/Head, $Enemy_Parts/Upper_Right/Chest, 
	$Enemy_Parts/Upper_Right/R_Arm, $Enemy_Parts/Upper_Right/R_Forearm, $Enemy_Parts/Upper_Right/R_Forearm/R_Hand, 
	$Enemy_Parts/Upper_Left/L_Arm, $Enemy_Parts/Upper_Left/L_Forearm, $Enemy_Parts/Upper_Left/L_Forearm/L_Hand, 
	$Enemy_Parts/Lower/R_Thigh, $Enemy_Parts/Lower/R_Leg, $Enemy_Parts/Lower/R_Leg/R_Foot,
	$Enemy_Parts/Lower/L_Thigh, $Enemy_Parts/Lower/L_Leg, $Enemy_Parts/Lower/L_Leg/L_Foot]

onready var enemy_sprites = [
	$Enemy_Parts/Upper_Right/Head/Sprite, $Enemy_Parts/Upper_Right/Chest/Sprite, 
	$Enemy_Parts/Upper_Right/R_Arm/Sprite, $Enemy_Parts/Upper_Right/R_Forearm/Sprite, $Enemy_Parts/Upper_Right/R_Forearm/R_Hand/Sprite, 
	$Enemy_Parts/Upper_Left/L_Arm/Sprite, $Enemy_Parts/Upper_Left/L_Forearm/Sprite, $Enemy_Parts/Upper_Left/L_Forearm/L_Hand/Sprite, 
	$Enemy_Parts/Lower/R_Thigh/Sprite, $Enemy_Parts/Lower/R_Leg/Sprite, $Enemy_Parts/Lower/R_Leg/R_Foot/Sprite,
	$Enemy_Parts/Lower/L_Thigh/Sprite, $Enemy_Parts/Lower/L_Leg/Sprite, $Enemy_Parts/Lower/L_Leg/L_Foot/Sprite]

onready var enemy_dmg = [
	$Enemy_Parts/Upper_Right/Head/Sprite_DMG, $Enemy_Parts/Upper_Right/Chest/Sprite_DMG,
	$Enemy_Parts/Upper_Right/R_Arm/Sprite_DMG, $Enemy_Parts/Upper_Right/R_Forearm/Sprite_DMG,
	$Enemy_Parts/Upper_Left/L_Arm/Sprite_DMG, $Enemy_Parts/Upper_Left/L_Forearm/Sprite_DMG,
	$Enemy_Parts/Lower/L_Leg/Sprite_DMG, $Enemy_Parts/Lower/L_Thigh/Sprite_DMG,
	$Enemy_Parts/Lower/R_Leg/Sprite_DMG, $Enemy_Parts/Lower/R_Thigh/Sprite_DMG]

onready var weapon_parts = [
	$Enemy_Parts/Upper_Right/Weapon_Set, $Enemy_Parts/Upper_Right/Weapon_Set/Weapon, 
	$Enemy_Parts/Upper_Right/Weapon_Set/Reloader, 
	$Enemy_Parts/Upper_Right/Weapon_Set/Fire]

onready var weapon_sprites = [
	$Enemy_Parts/Upper_Right/Weapon_Set/Weapon/Sprite, 
	$Enemy_Parts/Upper_Right/Weapon_Set/Reloader/Sprite, 
	$Enemy_Parts/Upper_Right/Weapon_Set/Fire/Sprite]



func _staggered():
	staggered = false



func _ready():
	randomize()
	speed = S[randi() % S.size()]
	option = OP[randi() % OP.size()]
	weapon_option = WO[randi() % WO.size()]
	
	match option:
		1:
			for i in enemy_sprites.size():
				enemy_sprites[i].play("Option1")
		2:
			for i in enemy_sprites.size():
				enemy_sprites[i].play("Option2")
		3:
			for i in enemy_sprites.size():
				enemy_sprites[i].play("Option3")
		4:
			for i in enemy_sprites.size():
				enemy_sprites[i].play("Option4")
	
	
	match weapon_option:
		1:
			weapon_sprites[0].play("Glock")
			weapon_sprites[1].play("Glock")
		2:
			weapon_sprites[0].play("Colt")
			weapon_sprites[1].play("Colt")


func _physics_process(delta):
	if staggered == true:
		$AnimationPlayerLower.stop()
		$AnimationPlayerUpper.stop()
		$AnimationPlayerFull.play("staggered")
		$audio_walk.stop()
	else:
		if life > 0:
			if moving == true && life > 0:
				$AnimationPlayerLower.play("walk")
				if $audio_walk.playing == false:
					$audio_walk.play()
			elif stop == true && life > 0: 
				$AnimationPlayerLower.play("idle")
				$audio_walk.stop()
			
			
			if aim == true:
				$AnimationPlayerUpper.play("aim")
			elif attack == true:
				$AnimationPlayerUpper.play("fire")
				$Enemy_Parts/Upper_Right/Weapon_Set/Fire/Sprite.play("Fire")
			elif reload == true:
				$AnimationPlayerUpper.play("reload")
			else:
				$AnimationPlayerUpper.play("idle")
			
			
			if attack == false:
				$audio_shoot.stop()
				$Timer_Shoot.stop()
			if reload == false:
				$audio_reload.stop()
			
			if target:
				if global_position.x >= target.global_position.x:
					flip = true
				if global_position.x <= target.global_position.x:
					flip = false
				
				
				if flee == false:
					if moving == true:
						velocity = global_position.direction_to(target.global_position)
						move_and_collide(velocity * speed * delta)
				else:
					if moving == true:
						velocity = -(global_position.direction_to(target.global_position))
						move_and_collide(velocity * speed * delta)
				
				
				
				if Global.dodge == true:
					set_collision_layer_bit(2, false)
					set_collision_mask_bit(1, false)
				else:
					set_collision_layer_bit(2, true)
					set_collision_mask_bit(1, true)
	
	
	for area in $Area2D_Ground.get_overlapping_areas():
		layer = LAYER._get_layer(area.name, layer)
		z_index = LAYER._get_z_index(area.name, z_index)
	
	
	if attack == false || life <= 0 || staggered == true:
		$Enemy_Parts/Upper_Right/Weapon_Set/Fire/Sprite.play("default")


func _cut_DMG():
	flee = true
	stop = false
	attack = false
	reload = false
	moving = true
	if $Enemy_Parts/Upper_Right/Head/Sprite_DMG.animation == "default":
		randomize()
		damage = DMG[randi() % DMG.size()]
	else:
		while damage == 6 || damage == 7:
			randomize()
			damage = DMG[randi() % DMG.size()]
	
	randomize()
	audio_dmg = ADMG[randi() % ADMG.size()]
	match audio_dmg:
		1:
			audio = $audio_dmg_1
		2:
			audio = $audio_dmg_2
		3:
			audio = $audio_dmg_3
		4:
			audio = $audio_dmg_4
	
	match damage:
		1:
			$Enemy_Parts/Lower/R_Thigh/Sprite_DMG.play("option1")
			$Enemy_Parts/Lower/R_Leg/Sprite_DMG.play("option1")
		2:
			$Enemy_Parts/Lower/L_Thigh/Sprite_DMG.play("option1")
			$Enemy_Parts/Lower/L_Leg/Sprite_DMG.play("option1")
		3:
			$Enemy_Parts/Upper_Right/R_Arm/Sprite_DMG.play("option1")
			$Enemy_Parts/Upper_Right/R_Forearm/Sprite_DMG.play("option1")
		4:
			$Enemy_Parts/Upper_Left/L_Arm/Sprite_DMG.play("option1")
			$Enemy_Parts/Upper_Left/L_Forearm/Sprite_DMG.play("option1")
		5:
			$Enemy_Parts/Upper_Right/Chest/Sprite_DMG.play("option1")
		6:
			$Enemy_Parts/Upper_Right/Head/Sprite_DMG.play("option1")
		7:
			$Enemy_Parts/Upper_Right/Head/Sprite_DMG.play("option2")
	
	audio.play()
	$Timer_audio.start()


func _dead():
	moving = false
	stop = false
	attack = false
	reload = false
	
	$CollisionShape2D.queue_free()
	$Area2D_Enemy_Pistol.queue_free()
	$Area2D_Follow.queue_free()
	$Area2D_Stop.queue_free()
	$AnimationPlayerUpper.queue_free()
	$AnimationPlayerLower.queue_free()
	$AnimationPlayerFull.queue_free()
	$Timer_Flip.queue_free()
	$audio_shoot.queue_free()
	$audio_reload.queue_free()
	
	
	
	
	if staggered == false:
		randomize()
		dead = DEAD[randi() % DEAD.size()]
		match dead:
			1:
				$AnimationPlayerDead.play("Dead1")
			2:
				$AnimationPlayerDead.play("Dead2")
			3:
				$AnimationPlayerDead.play("Dead3")
	else:
		staggered = false
		$AnimationPlayerDead.play("Dead(stagger)")
	
	randomize()
	med_drop = MD[randi() % MD.size()]
	if med_drop == 1:
		var medkit = MEDKIT.instance()
		medkit._set_layer(layer)
		get_parent().add_child(medkit)
		medkit.z_as_relative = false
		medkit.position = $Area2D_Ground/CollisionShape2D.global_position


func _on_Area2D_Enemy_Pistol_area_entered(area):
	if layer == LAYER.playerLayer:
		match area.name:
			"Area2D_Katana":
				$audio_cut_dmg_1.play()
				life -= Global.katana_DMG
				_cut_DMG()
			"Area2D_Hammer":
				$audio_smash_dmg_1.play()
				life -= Global.hammer_DMG
				_cut_DMG()
			"Area2D_Hammer_stagger":
				$audio_smash_dmg_1.play()
				life -= Global.hammer_DMG/3
				staggered = true
				_cut_DMG()
			"Area2D_Katar":
				$audio_cut_dmg_2.play()
				life -= Global.katar_DMG
				_cut_DMG()
			"Area2D_Axe":
				life -= Global.axe_DMG
				_cut_DMG()
			"Area2D_Tonfa":
				life -= Global.tonfa_DMG
				_cut_DMG()
			"Area2D_Wakizashi":
				life -= Global.wakizashi_DMG
				_cut_DMG()
			"Area2D_Great_Sword":
				life -= Global.great_sword_DMG
				_cut_DMG()
	
	
	
	if life <= 0:
		_dead()


func _on_Area2D_Ground_area_entered(area):
	layer = LAYER._get_layer(area.name, layer)
	z_index = LAYER._get_z_index(area.name, z_index)


func _on_Area2D_Follow_body_entered(body):
	if body.name == "Player" && life > 0:
		target = body
		moving = true
		stop = false
		attack = false
		reload = false


func _on_Area2D_Follow_body_exited(body):
	if body.name == "Player" && life > 0:
		target = body
		moving = true
		stop = false
		attack = false
		reload = false


func _on_Area2D_Stop_body_entered(body):
	if body.name == "Player" && life > 0:
		moving = false
		stop = true
		flee = false
		if aim == false && attack == false:
			aim = true
		if $Timer_Aim.is_stopped() == true && attack == false:
			$Timer_Aim.start()


func _on_Area2D_Stop_body_exited(body):
	if body.name == "Player" && life > 0:
		if flee == true:
			moving = false
			stop = true
			flee = false
			if aim == false && attack == false:
				aim = true
			if $Timer_Aim.is_stopped() == true && attack == false:
				$Timer_Aim.start()
#		else:
#			moving = true
#			stop = false
#			attack = false


func _on_Timer_Aim_timeout():
	if life > 0:
		aim = false
		attack = true
		$Timer_Shoot.start()


func _on_Timer_Shoot_timeout():
	if attack == true && ammo > 0 && stop == true && life > 0:
		#$Audio_Shoot.play()
		ammo -= 1
		var bulletInstance = BULLET.instance()
		bulletInstance._set_layer(layer)
		if flip == false:
			get_parent().add_child(bulletInstance)
			bulletInstance.position = $PositionRight.global_position
			bulletInstance._set_direction(1)
		else:
			get_parent().add_child(bulletInstance)
			bulletInstance.position = $PositionLeft.global_position
			bulletInstance._set_direction(-1)
	elif ammo <= 0 && life > 0:
		attack = false
		reload = true
		$Timer_Reload.start()


func _on_Timer_Reload_timeout():
	if reload == true && life > 0:
		ammo = 12
		reload = false
		attack = true
		$Timer_Shoot.start()


func _on_Timer_Flip_timeout():
	if flip == false:
		for i in enemy_sprites.size():
			enemy_sprites[i].flip_h = false
		
		
		for i in enemy_dmg.size():
			enemy_dmg[i].flip_h = false
		
		
		for i in weapon_sprites.size():
			weapon_sprites[i].flip_h = false
		
	else:
		for i in enemy_parts.size():
			enemy_parts[i].position.x *= -1
			enemy_parts[i].rotation_degrees *= -1
		
		
		for i in enemy_sprites.size():
			enemy_sprites[i].flip_h = true
		
		
		for i in enemy_dmg.size():
			enemy_dmg[i].flip_h = true
		
		
		for i in weapon_parts.size():
			weapon_parts[i].position.x *= -1
			weapon_parts[i].rotation_degrees *= -1
		
		
		for i in weapon_sprites.size():
			weapon_sprites[i].flip_h = true


func _on_AnimationPlayerDead_animation_finished(anim_name):
	if life <= 0:
		$AnimationPlayerDead.queue_free()



func _on_Timer_audio_timeout():
	audio.stop()
