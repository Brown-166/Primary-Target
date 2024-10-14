extends KinematicBody2D


var life = 250
var stamina = 60
var velocity = Vector2.ZERO
var speed = 250
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
var dodge = false
var dodge_range = speed * 2.5

var TIME = [1, 2, 3, 4, 5]
var dodge_time


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

onready var katar = [$Boss_Parts/Upper_Right/Katar, $Boss_Parts/Upper_Left/Katar]

onready var katar_sprites = [
	$Boss_Parts/Upper_Right/Katar/Hilt, $Boss_Parts/Upper_Right/Katar/Blade,
	$Boss_Parts/Upper_Left/Katar/Hilt, $Boss_Parts/Upper_Left/Katar/Blade]

onready var katar_collisions = [
	$Boss_Parts/Upper_Right/Katar/Blade/Boss_Katar/CollisionPolygon2D,
	$Boss_Parts/Upper_Left/Katar/Blade/Boss_Katar/CollisionPolygon2D
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
	
#	if moving == false && follow == false && dodge == false:
#		attack = true
	if follow == true:
		moving = true
		stop = false


func _dodge():
	moving = true
	stop = false
	attack = false
	dodge = false
	randomize()
	dodge_time = TIME[randi() % TIME.size()]


func _staggered():
	staggered = false


func _ready():
	for i in boss_sprites.size():
		boss_sprites[i].play("default")
	for i in katar_collisions.size():
		katar_collisions[i].disabled = true
	$AnimationPlayerUpper.playback_speed = 2
	$AnimationPlayerFull.playback_speed = 4
	
	randomize()
	dodge_time = TIME[randi() % TIME.size()]
	$Timer_Dodge.wait_time = dodge_time
	
	randomize()
	dodge_time = TIME[randi() % TIME.size()]


func _physics_process(delta):
	if life > 0:
		if staggered == true:
			$AnimationPlayerUpper.stop()
			$AnimationPlayerLower.stop()
			$AnimationPlayerFull.play("staggered")
			$audio_walk.stop()
		else:
			if dodge == true:
				$AnimationPlayerUpper.stop()
				$AnimationPlayerLower.stop()
				$AnimationPlayerFull.play("dodge")
				if flip == false:
					velocity.x += dodge_range
				else:
					velocity.x -= dodge_range
				velocity = velocity.normalized()
				move_and_collide(velocity * dodge_range * delta)
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
					if attack == false && staggered == false && dodge == false:
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
						if stamina >= 10:
							if $Timer_Dodge.is_stopped() == true:
								$Timer_Dodge.start()
						attack = true
					elif body.name == "Player" && layer != LAYER.playerLayer:
						follow = true
				
				for area in $Boss_Parts/Upper_Left/Katar/Blade/Boss_Katar.get_overlapping_areas():
					if layer == LAYER.playerLayer && staggered == false:
						if Global.block == true && Global.flip != flip:
							if Global.stamina >= 10:
								blocked = true
				
				for area in $Boss_Parts/Upper_Right/Katar/Blade/Boss_Katar.get_overlapping_areas():
					if layer == LAYER.playerLayer && staggered != false:
						if Global.block == true && Global.flip == flip:
							if Global.stamina >= 10:
								blocked = true
			
			
			
			for area in $Area2D_Ground.get_overlapping_areas():
				layer = LAYER._get_layer(area.name, layer)
				z_index = LAYER._get_z_index(area.name, z_index)
			
			if layer == LAYER.playerLayer && Global.dodge == true:
				set_collision_layer_bit(2, false)
				set_collision_mask_bit(1, false)
			elif dodge == true:
				set_collision_layer_bit(2, false)
				set_collision_mask_bit(1, false)
			else:
				set_collision_layer_bit(2, true)
				set_collision_mask_bit(1, true)
		
		
		if stamina > 60:
			stamina = 60
	
#	print("life: " + String(life))
#	print("dodge: " + String(dodge))
#	print("stamina: " + String(stamina))
#	print(dodge_time)
	print(dodge)

func _dead():
	moving = false
	stop = false
	attack = false
	
	$CollisionShape2D.queue_free()
	$Area2D_Boss_Blue.queue_free()
	$Area2D_Follow.queue_free()
	$Area2D_Close.queue_free()
	$AnimationPlayerUpper.queue_free()
	$AnimationPlayerLower.queue_free()
	$Timer_Stamina.queue_free()
	
	$AnimationPlayerFull.play("Dead")


func _on_Area2D_Boss_Blue_area_entered(area):
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
		
		
		if life <= 0:
			$AnimationPlayerFull.playback_speed = 1
			_dead()


func _on_Area2D_Follow_body_entered(body):
	if body.name == "Player" && life > 0:
		target = body
		moving = true
		stop = false
		attack = false
		dodge = false
		if $Timer_Stamina.is_stopped() == true:
			$Timer_Stamina.start()


func _on_Area2D_Close_body_entered(body):
	if body.name == "Player" && life > 0  && layer == LAYER.playerLayer:
		moving = false
		stop = true
		follow = false
		if stamina >= 10:
			if $Timer_Dodge.is_stopped() == true:
				$Timer_Dodge.start()
		attack = true


func _on_Area2D_Close_body_exited(body):
	if body.name == "Player" && life > 0:
		if $Timer_Follow.is_stopped() == true:
			$Timer_Follow.start()


func _on_Boss_Katar_area_entered(area):
	if layer == LAYER.playerLayer && staggered == false:
		if Global.block == true && Global.flip != flip:
			if Global.stamina >= 10:
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
		for i in boss_sprites.size():
			boss_sprites[i].flip_h = false
			
		for i in katar_sprites.size():
			katar_sprites[i].flip_h = false
	else:
		for i in boss_parts.size():
			boss_parts[i].position.x *= -1
			boss_parts[i].rotation_degrees *= -1
		
		for i in boss_sprites.size():
			boss_sprites[i].flip_h = true
			
		for i in katar.size():
			katar[i].position.x *= -1
			katar[i].rotation_degrees *= -1
		
		for i in katar_sprites.size():
			katar_sprites[i].flip_h = true


func _on_AnimationPlayerFull_animation_finished(anim_name):
	if life <= 0: 
		$Timer_Flip.queue_free()


func _on_Timer_Stamina_timeout():
	if stamina < 60:
		stamina += 2


func _on_Timer_Dodge_timeout():
	if stamina >= 10:
		dodge = true
		stamina -= 10
	$Timer_Dodge.stop()


func _on_Timer_Follow_timeout():
	follow = true
	moving = true
	stop = false
	attack = false
	dodge = false
