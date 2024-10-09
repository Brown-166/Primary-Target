extends KinematicBody2D

var life = 150
var stamina
var S = [3, 4, 4, 5]
var max_stamina
var velocity = Vector2.ZERO
var speed = 150
var layer : int
var moving = false
var stop = true
var staggered = false
var blocked = false
var OP = [1, 2]
var option
var KO = [1, 2]
var knife_option
var DMG = [1, 2, 3, 4, 5, 6, 7]
var damage
var ADMG = [1, 2, 3, 4]
var audio_dmg
var audio
var DEAD = [1,2,3]
var dead = 0

var flip = false
var target : KinematicBody2D = null
var follow = false
var back = false

var attack = false
var attackVar = false


onready var enemy_parts = [
	$Enemy_Parts/Upper_Right/Head, $Enemy_Parts/Upper_Right/Chest, 
	$Enemy_Parts/Upper_Right/R_Arm, $Enemy_Parts/Upper_Right/R_Forearm, $Enemy_Parts/Upper_Right/R_Forearm/R_Hand, 
	$Enemy_Parts/Upper_Left/L_Arm, $Enemy_Parts/Upper_Left/L_Forearm, $Enemy_Parts/Upper_Left/L_Forearm/L_Hand, 
	$Enemy_Parts/Lower/R_Thigh, $Enemy_Parts/Lower/R_Leg, $Enemy_Parts/Lower/R_Leg/R_Foot,
	$Enemy_Parts/Lower/L_Thigh, $Enemy_Parts/Lower/L_Leg, $Enemy_Parts/Lower/L_Leg/L_Foot, $Enemy_Parts/Upper_Right/Knife]

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
	

onready var knife_sprites = [$Enemy_Parts/Upper_Right/Knife/Sprite]


func _attack():
	if global_position.x >= target.global_position.x:
		flip = true
	if global_position.x <= target.global_position.x:
		flip = false
	attack = false
	blocked = false
	stamina -= 1
	if attackVar == false:
		attackVar = true
	else:
		attackVar = false
	
	if moving == false && follow == false:
		if stamina > 0:
			attack = true
		else:
			back = true
			moving = true
			stop = false
	elif follow == true || layer != LAYER.playerLayer:
		moving = true
		stop = false


func _staggered():
	staggered = false


func _ready():
	randomize()
	option = OP[randi() % OP.size()]
	knife_option = KO[randi() % KO.size()]
	max_stamina = S[randi() % S.size()]
	stamina = max_stamina
	
	match option:
		1:
			for i in enemy_sprites.size():
				enemy_sprites[i].play("Option1")
		2:
			for i in enemy_sprites.size():
				enemy_sprites[i].play("Option2")
	
	
	match knife_option:
		1:
			knife_sprites[0].play("Knife1")
		2:
			knife_sprites[0].play("Knife2")


func _physics_process(delta):
	if life > 0:
		if staggered == true:
			$AnimationPlayerUpper.stop()
			$AnimationPlayerLower.stop()
			$AnimationPlayerFull.play("staggered")
		else:
			if moving == true:
				$AnimationPlayerLower.play("walk")
				if $audio_walk.playing == false:
					$audio_walk.play()
			elif stop == true: 
				$AnimationPlayerLower.play("idle")
				$audio_walk.stop()
				
			if attack == true:
				if attackVar == false:
					$AnimationPlayerUpper.play("attack_1")
				else:
					$AnimationPlayerUpper.play("attack_2")
			else:
				$AnimationPlayerUpper.play("idle")
			
			
			if target:
				if global_position.x >= target.global_position.x:
					flip = true
				if global_position.x <= target.global_position.x:
					flip = false
				
				if back == false:
					if moving == true:
						velocity = global_position.direction_to(target.global_position)
						move_and_collide(velocity * speed * delta)
				else:
					if moving == true:
						velocity = -(global_position.direction_to(target.global_position))
						move_and_collide(velocity * speed * delta)
				
				
			for body in $Area2D_Close.get_overlapping_bodies():
				if body.name == "Player" && layer == LAYER.playerLayer:
					if stamina > 0:
						moving = false
						stop = true
						attack = true
					else:
						back = true
				elif body.name == "Player" && layer != LAYER.playerLayer:
					follow = true
			
			
			for area in $Area2D_Ground.get_overlapping_areas():
				layer = LAYER._get_layer(area.name, layer)
				z_index = LAYER._get_z_index(area.name, z_index)
			
			
			for area in $Enemy_Parts/Upper_Right/Knife/Knife_2D.get_overlapping_areas():
					if layer == LAYER.playerLayer && staggered == false:
						if Global.block == true && Global.flip != flip:
							if Global.stamina >= 10:
								if blocked == false:
									blocked = true
									Global.blocked = true
									Global.stamina -= 10
			
			
			if layer == LAYER.playerLayer && Global.dodge == true:
				set_collision_layer_bit(2, false)
				set_collision_mask_bit(1, false)
			else:
				set_collision_layer_bit(2, true)
				set_collision_mask_bit(1, true)


func _cut_DMG():
	stop = false
	attack = false
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
	
	$CollisionShape2D.queue_free()
	$Area2D_Enemy_Knife.queue_free()
	$Area2D_Follow.queue_free()
	$Area2D_Close.queue_free()
	$AnimationPlayerUpper.queue_free()
	$AnimationPlayerLower.queue_free()
	$AnimationPlayerFull.queue_free()
	$Timer_Flip.queue_free()
	
	
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


func _on_Area2D_Enemy_Knife_area_entered(area):
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
		
#
#		if area.name == "Area2D_Player":
#			attack = false
#			moving = true
#			stop = false
#			back = true
		
		if life <= 0:
			_dead()


func _on_Area2D_Follow_body_entered(body):
	if body.name == "Player" && life > 0:
		target = body
		moving = true
		stop = false
		attack = false


#func _on_Area2D_Close_body_entered(body):
#	if body.name == "Player" && life > 0  && layer == LAYER.playerLayer:
#		moving = false
#		stop = true
#		follow = false
#		if attack == false:
#			attack = true
#
#
#func _on_Area2D_Close_body_exited(body):
#	if body.name == "Player" && life > 0:
#		follow = true


func _on_Knife_2D_area_entered(area):
	if layer == LAYER.playerLayer && staggered == false:
		if Global.block == true && Global.flip != flip:
			if Global.stamina >= 10:
				if blocked == false:
					blocked = true
					Global.blocked = true
					Global.stamina -= 10
			else:
				Global.life -= 5
				Global.stamina -= 10
		elif area.name == "Area2D_Player":
			if Global.dodge == false && blocked == false:
				Global.life -= 5


func _on_Area2D_Ground_area_entered(area):
	#layer = LAYER._get_layer(area.name, layer)
	#z_index = LAYER._get_z_index(area.name, z_index)
	pass


func _on_Timer_Flip_timeout():
	if flip == false:
		for i in enemy_sprites.size():
			enemy_sprites[i].flip_h = false
		for i in enemy_dmg.size():
			enemy_dmg[i].flip_h = false
		for i in knife_sprites.size():
			knife_sprites[i].flip_h = false 
	else:
		for i in enemy_parts.size():
			enemy_parts[i].position.x *= -1
			enemy_parts[i].rotation_degrees *= -1
		for i in enemy_sprites.size():
			enemy_sprites[i].flip_h = true
		for i in enemy_dmg.size():
			enemy_dmg[i].flip_h = true
		for i in knife_sprites.size():
			knife_sprites[i].flip_h = true


func _on_AnimationPlayerFull_animation_finished(anim_name):
	if life <= 0: 
		$Timer_Flip.queue_free()


func _on_Timer_Stamina_timeout():
	if stop == true && moving == false && attack == false:
		if stamina < max_stamina:
			stamina += 1
		else:
			back = false
			moving = true
			stop = false


func _on_Timer_audio_timeout():
	$Timer_audio.stop()


func _on_Area2D_Stop_body_exited(body):
	if body.name == "Player" && life > 0:
		if back == true:
			moving = false
			stop = true
