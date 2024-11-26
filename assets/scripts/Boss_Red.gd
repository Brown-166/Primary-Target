extends KinematicBody2D

var life = 300
var stamina = 15
var velocity = Vector2.ZERO
var speed = 150
var layer : int
var moving = false
var stop = true
var staggered = false
var blocked = false

var flip = false
var target : KinematicBody2D = null
var follow = false
var back = false

var attack = false
var attackVar = true
var hammer_stagger = false


var MEDKIT = preload("res://assets/objects/medKit.tscn")


onready var boss_parts = [
	$Boss_Parts/Upper_Right, $Boss_Parts/Upper_Left, $Boss_Parts/Lower,
	$Boss_Parts/Upper_Right/Head, $Boss_Parts/Upper_Right/Chest,
	$Boss_Parts/Upper_Right/R_Arm, $Boss_Parts/Upper_Right/R_Arm/R_Forearm, $Boss_Parts/Upper_Right/R_Arm/R_Forearm/R_Hand,
	$Boss_Parts/Upper_Left/L_Arm, $Boss_Parts/Upper_Left/L_Arm/L_Forearm, $Boss_Parts/Upper_Left/L_Arm/L_Forearm/L_Hand,
	$Boss_Parts/Lower/R_Thigh, $Boss_Parts/Lower/R_Thigh/R_Leg, $Boss_Parts/Lower/R_Thigh/R_Leg/R_Foot,
	$Boss_Parts/Lower/L_Thigh, $Boss_Parts/Lower/L_Thigh/L_Leg, $Boss_Parts/Lower/L_Thigh/L_Leg/L_Foot
]

onready var boss_sprites = [
	$Boss_Parts/Upper_Right/Head/Sprite, $Boss_Parts/Upper_Right/Chest/Sprite,
	$Boss_Parts/Upper_Right/R_Arm/Sprite, $Boss_Parts/Upper_Right/R_Arm/R_Forearm/Sprite, $Boss_Parts/Upper_Right/R_Arm/R_Forearm/R_Hand/Sprite,
	$Boss_Parts/Upper_Left/L_Arm/Sprite, $Boss_Parts/Upper_Left/L_Arm/L_Forearm/Sprite, $Boss_Parts/Upper_Left/L_Arm/L_Forearm/L_Hand/Sprite,
	$Boss_Parts/Lower/R_Thigh/Sprite, $Boss_Parts/Lower/R_Thigh/R_Leg/Sprite, $Boss_Parts/Lower/R_Thigh/R_Leg/R_Foot/Sprite,
	$Boss_Parts/Lower/L_Thigh/Sprite, $Boss_Parts/Lower/L_Thigh/L_Leg/Sprite, $Boss_Parts/Lower/L_Thigh/L_Leg/L_Foot/Sprite
]

onready var hammer = $Boss_Parts/Upper_Right/Hammer

onready var hammer_sprites = [$Boss_Parts/Upper_Right/Hammer/Hilt, $Boss_Parts/Upper_Right/Hammer/Head]

onready var hammer_collisions = [
	$Boss_Parts/Upper_Right/Hammer/Head/Boss_Hammer/CollisionPolygon2D,
	$Boss_Parts/Upper_Right/Hammer/Head/Boss_Stagger/CollisionPolygon2D
]


func _attack():
	if global_position.x >= target.global_position.x:
		flip = true
	if global_position.x <= target.global_position.x:
		flip = false
	attack = false
	blocked = false
	if attackVar == false:
		attackVar = true
	else:
		attackVar = false
	
	if moving == false && follow == false:
		if stamina == 60:
			hammer_stagger = true
		else:
			attack = true
	elif follow == true || layer != LAYER.playerLayer:
		moving = true
		stop = false


func _hammer_stagger():
	if global_position.x >= target.global_position.x:
		flip = true
	if global_position.x <= target.global_position.x:
		flip = false
	hammer_stagger = false
	stamina = 0
	attackVar = false
	if moving == false && follow == false:
		attack = true
	elif follow == true || layer != LAYER.playerLayer:
		moving = true
		stop = false


func _staggered():
	staggered = false


func _ready():
	for i in boss_sprites.size():
		boss_sprites[i].play("default")
	for i in hammer_collisions.size():
		hammer_collisions[i].disabled = true
	$AnimationPlayerUpper.playback_speed = 0.6


func _physics_process(delta):
	if life > 0:
		if staggered == true:
			$AnimationPlayerUpper.stop()
			$AnimationPlayerLower.stop()
			$AnimationPlayerFull.play("staggered")
			$audio_walk.stop()
		else:
			if moving == true:
				$AnimationPlayerLower.play("walk")
				if $audio_walk.playing == false:
					$audio_walk.play()
			elif stop == true: 
				$AnimationPlayerLower.play("idle")
				$audio_walk.stop()
			
			
			if hammer_stagger == true:
				$AnimationPlayerUpper.play("stagger")
				attackVar = true
			elif attack == true:
				if attackVar == false:
					$AnimationPlayerUpper.play("attack_1")
				else:
					$AnimationPlayerUpper.play("attack_2")
			else:
				$AnimationPlayerUpper.play("idle")
			
			
			if target:
				if attack == false && hammer_stagger == false && staggered == false:
					if global_position.x >= target.global_position.x:
						flip = true
					if global_position.x <= target.global_position.x:
						flip = false
				
				if back == true:
					velocity = -(global_position.direction_to(target.global_position))
					move_and_collide(velocity * speed * delta)
				elif back == false && moving == true:
					velocity = global_position.direction_to(target.global_position)
					move_and_collide(velocity * speed * delta)
				
				
			for body in $Area2D_Close.get_overlapping_bodies():
				if body.name == "Player" && layer == LAYER.playerLayer:
					moving = false
					stop = true
					if stamina == 30:
						hammer_stagger = true
					else:
						attack = true
				elif body.name == "Player" && layer != LAYER.playerLayer:
					follow = true
			for area in $Area2D_Ground.get_overlapping_areas():
				layer = LAYER._get_layer(area.name, layer)
				z_index = LAYER._get_z_index(area.name, z_index)
			
			for area in $Boss_Parts/Upper_Right/Hammer/Head/Boss_Hammer.get_overlapping_areas():
					if layer == LAYER.playerLayer && staggered == false:
						if Global.block == true && Global.flip != flip:
							if Global.stamina >= 20:
								if blocked == false:
									blocked = true
									Global.stamina -= 20
			
			if layer == LAYER.playerLayer && Global.dodge == true:
				set_collision_layer_bit(2, false)
				set_collision_mask_bit(1, false)
			else:
				set_collision_layer_bit(2, true)
				set_collision_mask_bit(1, true)


func _dead():
	moving = false
	stop = false
	attack = false
	
	$CollisionShape2D.queue_free()
	$Area2D_Boss_Red.queue_free()
	$Area2D_Follow.queue_free()
	$Area2D_Close.queue_free()
	$AnimationPlayerUpper.queue_free()
	$AnimationPlayerLower.queue_free()
	$Timer_Stamina.queue_free()
	
	#$Audio_DMG3.play()
	
	$AnimationPlayerFull.play("Dead")
	

	var medkit = MEDKIT.instance()
	medkit._set_layer(layer)
	get_parent().add_child(medkit)
	medkit.z_as_relative = false
	medkit.position = $Area2D_Ground/CollisionShape2D.global_position


func _on_Area2D_Boss_Red_area_entered(area):
	if layer == LAYER.playerLayer:
		match area.name:
			"Area2D_Katana":
				$audio_cut_dmg_1.play()
				life -= Global.katana_DMG
			"Area2D_Hammer":
				$audio_smash_dmg_1.play()
				life -= Global.hammer_DMG
			"Area2D_Hammer_stagger":
				$audio_smash_dmg_1.play()
				life -= Global.hammer_DMG/3
				staggered = true
			"Area2D_Katar":
				$audio_cut_dmg_2.play()
				life -= Global.katar_DMG
			"Area2D_Axe":
				life -= Global.axe_DMG
			"Area2D_Tonfa":
				life -= Global.tonfa_DMG
			"Area2D_Wakizashi":
				life -= Global.wakizashi_DMG
			"Area2D_Great_Sword":
				life -= Global.great_sword_DMG
		
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
		hammer_stagger = false
		if $Timer_Stamina.is_stopped() == true:
			$Timer_Stamina.start()


func _on_Area2D_Close_body_entered(body):
	if body.name == "Player" && life > 0  && layer == LAYER.playerLayer:
		moving = false
		stop = true
		follow = false
		if stamina == 30:
			hammer_stagger = true
		else:
			attack = true


func _on_Area2D_Close_body_exited(body):
	if body.name == "Player" && life > 0:
		follow = true


func _on_Boss_Hammer_area_entered(area):
	if layer == LAYER.playerLayer && staggered == false:
		if Global.block == true && Global.flip != flip:
			if Global.stamina >= 20:
				if blocked == false:
					Global.stamina -= 20
					blocked = true
					Global.blocked = true
			else:
				Global.life -= 20
				Global.stamina -= 20
				Global.hit = "attack"
		elif area.name == "Area2D_Player":
			if Global.dodge == false && blocked == false:
				Global.life -= 20
				Global.hit = "attack"


func _on_Area2D_Ground_area_entered(area):
	#layer = LAYER._get_layer(area.name, layer)
	#z_index = LAYER._get_z_index(area.name, z_index)
	pass


func _on_Timer_Flip_timeout():
	if flip == false:
#		for i in boss_sprites.size():
#			boss_sprites[i].flip_h = false
#
#		for i in hammer_sprites.size():
#			hammer_sprites[i].flip_h = false
		$Boss_Parts.scale.x = 1
	else:
#		for i in boss_parts.size():
#			boss_parts[i].position.x *= -1
#			boss_parts[i].rotation_degrees *= -1
#
#		for i in boss_sprites.size():
#			boss_sprites[i].flip_h = true
#
#		hammer.position.x *= -1
#		hammer.rotation_degrees *= -1
#
#		for i in hammer_sprites.size():
#			hammer_sprites[i].flip_h = true
		$Boss_Parts.scale.x = -1


func _on_AnimationPlayerFull_animation_finished(anim_name):
	if life <= 0: 
		$Timer_Flip.queue_free()


func _on_Timer_Stamina_timeout():
	if stamina < 30:
		stamina += 1


func _on_Boss_Stagger_area_entered(area):
	if layer == LAYER.playerLayer && staggered == false:
		if area.name == "Area2D_Player":
			if Global.dodge == false:
				Global.life -= 10
				Global.staggered = true
				Global.hit = "attack"
