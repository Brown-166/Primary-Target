extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 200
var jumpForce = speed * 5
var gravity = speed * 5
var layer :int
var grounded = false
var moveRight = false
var moveLeft = false
var moveUp = false
var moveDown = false
var jump = false
var flip = false

var attack = false
var attackVar = true
var block = false
var blockVar = false
var stagger = false
var staggered = false
var dodge = false
var dodge_range = speed * 4
var special = false

var ANI_idle
var ANI_attack_1
var ANI_attack_2
var ANI_block
var ANI_block_b1
var ANI_block_b2
var ANI_stagger
var ANI_dodge
var ANI_special
var ANI_staggered
var ANI_dead

var dead_var = false

onready var player_parts = [$Player_Parts/Upper_Right/Head, $Player_Parts/Upper_Right/Chest, 
	$Player_Parts/Upper_Right/R_Arm, $Player_Parts/Upper_Right/R_Arm/R_Forearm, $Player_Parts/Upper_Right/R_Arm/R_Forearm/R_Hand,
	$Player_Parts/Upper_Left/L_Arm, $Player_Parts/Upper_Left/L_Arm/L_Forearm, $Player_Parts/Upper_Left/L_Arm/L_Forearm/L_Hand,
	$Player_Parts/Lower/R_Thigh, $Player_Parts/Lower/R_Thigh/R_Leg, $Player_Parts/Lower/R_Thigh/R_Leg/R_Foot, 
	$Player_Parts/Lower/L_Thigh, $Player_Parts/Lower/L_Thigh/L_Leg, $Player_Parts/Lower/L_Thigh/L_Leg/L_Foot]

onready var player_sprites = [$Player_Parts/Upper_Right/Head/Sprite, $Player_Parts/Upper_Right/Chest/Sprite, 
	$Player_Parts/Upper_Right/R_Arm/Sprite, $Player_Parts/Upper_Right/R_Arm/R_Forearm/Sprite, 
	$Player_Parts/Upper_Left/L_Arm/Sprite, $Player_Parts/Upper_Left/L_Arm/L_Forearm/Sprite,
	$Player_Parts/Upper_Right/R_Arm/R_Forearm/R_Hand/Sprite, $Player_Parts/Upper_Left/L_Arm/L_Forearm/L_Hand/Sprite,
	$Player_Parts/Lower/R_Thigh/Sprite, $Player_Parts/Lower/R_Thigh/R_Leg/Sprite, 
	$Player_Parts/Lower/L_Thigh/Sprite, $Player_Parts/Lower/L_Thigh/L_Leg/Sprite,
	$Player_Parts/Lower/R_Thigh/R_Leg/R_Foot/Sprite, $Player_Parts/Lower/L_Thigh/L_Leg/L_Foot/Sprite]

onready var weapons = [$Player_Parts/Upper_Right/R_Weapons/Katana, 
	$Player_Parts/Upper_Right/R_Weapons/Hammer, 
	$Player_Parts/Upper_Right/R_Weapons/Katar, $Player_Parts/Upper_Left/L_Weapons/Katar,
	$Player_Parts/Upper_Right/R_Weapons/Axe, 
	$Player_Parts/Upper_Right/R_Weapons/Tonfa, $Player_Parts/Upper_Left/L_Weapons/Tonfa,
	$Player_Parts/Upper_Right/R_Weapons/Wakizashi, $Player_Parts/Upper_Left/L_Weapons/Wakizashi, 
	$Player_Parts/Upper_Right/R_Weapons/Great_Sword]

onready var weapons_sprites = [$Player_Parts/Upper_Right/R_Weapons/Katana/Blade, 
	$Player_Parts/Upper_Right/R_Weapons/Hammer/Head, 
	$Player_Parts/Upper_Right/R_Weapons/Katar/Blade, $Player_Parts/Upper_Left/L_Weapons/Katar/Blade,
	$Player_Parts/Upper_Right/R_Weapons/Axe/Blade, 
	$Player_Parts/Upper_Right/R_Weapons/Tonfa/Body, $Player_Parts/Upper_Left/L_Weapons/Tonfa/Body,
	$Player_Parts/Upper_Right/R_Weapons/Wakizashi/Blade, $Player_Parts/Upper_Left/L_Weapons/Wakizashi/Blade, 
	$Player_Parts/Upper_Right/R_Weapons/Great_Sword/Blade]

onready var weapon_collisions = [$Player_Parts/Upper_Right/R_Weapons/Katana/Blade/Area2D_Katana/Collision_Katana, 
	$Player_Parts/Upper_Right/R_Weapons/Hammer/Head/Area2D_Hammer/Collision_Hammer, $Player_Parts/Upper_Right/R_Weapons/Hammer/Head/Area2D_Hammer_stagger/Collision_Hammer_stagger, 
	$Player_Parts/Upper_Right/R_Weapons/Katar/Blade/Area2D_Katar/Collision_Katar, $Player_Parts/Upper_Left/L_Weapons/Katar/Blade/Area2D_Katar/Collision_Katar,
	$Player_Parts/Upper_Right/R_Weapons/Axe/Blade/Area2D_Axe/Collision_Axe, 
	$Player_Parts/Upper_Right/R_Weapons/Tonfa/Body/Area2D_Tonfa/Collision_Tonfa, $Player_Parts/Upper_Left/L_Weapons/Tonfa/Body/Area2D_Tonfa/Collision_Tonfa,
	$Player_Parts/Upper_Right/R_Weapons/Wakizashi/Blade/Area2D_Wakizashi/Collision_Wakizashi, $Player_Parts/Upper_Left/L_Weapons/Wakizashi/Blade/Area2D_Wakizashi/Collision_Wakizashi, 
	$Player_Parts/Upper_Right/R_Weapons/Great_Sword/Blade/Area2D_Great_Sword/Collision_Great_Sword,
	$Area2D_Block/Collision_Block, $Area2D_Block/Collision_Block_top, $Area2D_Block/Collision_Block_bottom]





func _attack():
	attack = false


func _stamina():
	Global.stamina -= 33

func _stagger():
	stagger = false

func _dodge():
	dodge = false


func _staggered():
	Global.staggered = false
	staggered = false


func _jump():
	jump = false


func _weapon_set():
	for i in weapons.size():
		weapons[i].visible = false
		
	match Global.weapon:
		"katana":
			$Player_Parts/Upper_Right/R_Weapons/Katana.visible = true
			for i in player_sprites.size():
				player_sprites[i].play("Yellow")
			ANI_idle = "katana_idle"
			ANI_attack_1 = "katana_attack_1"
			ANI_attack_2 = "katana_attack_2"
			ANI_block = "katana_block"
			ANI_block_b1 = "katana_block_b1"
			ANI_block_b2 = "katana_block_b2"
			ANI_staggered = "katana_staggered"
			ANI_dead = "Dead_katana"
			$AnimationPlayerUpper.playback_speed = 1
			speed = 200
		
		"hammer":
			$Player_Parts/Upper_Right/R_Weapons/Hammer.visible = true
			for i in player_sprites.size():
				player_sprites[i].play("Red")
			ANI_idle = "hammer_idle"
			ANI_attack_1 = "hammer_attack_1"
			ANI_attack_2 = "hammer_attack_2"
			ANI_stagger = "hammer_stagger"
			ANI_staggered = "hammer_staggered"
			ANI_dead = "Dead_hammer"
			$AnimationPlayerUpper.playback_speed = 0.6
			speed = 150
		
		"katar":
			$Player_Parts/Upper_Right/R_Weapons/Katar.visible = true
			$Player_Parts/Upper_Left/L_Weapons/Katar.visible = true
			for i in player_sprites.size():
				player_sprites[i].play("Blue")
			ANI_idle = "katar_idle"
			ANI_attack_1 = "katar_attack_1"
			ANI_attack_2 = "katar_attack_2"
			ANI_dodge = "katar_dodge"
			ANI_staggered = "katar_staggered"
			ANI_dead = "Dead_katar"
			$AnimationPlayerUpper.playback_speed = 2
			$AnimationPlayerFull.playback_speed = 4
			speed = 250
		
		"axe":
			$Player_Parts/Upper_Right/R_Weapons/Axe.visible = true
			for i in player_sprites.size():
				player_sprites[i].play("Orange")
			ANI_idle = "axe_idle"
			ANI_attack_1 = "axe_attack_1"
			ANI_attack_2 = "axe_attack_2"
			ANI_block = "axe_block"
			ANI_stagger = "axe_stagger"
			ANI_special = "axe_special"
			ANI_staggered = "axe_staggered"
		
		"tonfa":
			$Player_Parts/Upper_Right/R_Weapons/Tonfa.visible = true
			$Player_Parts/Upper_Left/L_Weapons/Tonfa.visible = true
			for i in player_sprites.size():
				player_sprites[i].play("Purple")
			ANI_idle = "tonfa_idle"
			ANI_attack_1 = "tonfa_attack_1"
			ANI_attack_2 = "tonfa_attack_2"
			ANI_stagger = "tonfa_stagger"
			ANI_dodge = "tonfa_dodge"
			ANI_special = "tonfa_special"
			ANI_staggered = "tonfa_staggered"
		
		"wakizashi":
			$Player_Parts/Upper_Right/R_Weapons/Wakizashi.visible = true
			$Player_Parts/Upper_Left/L_Weapons/Wakizashi.visible = true
			for i in player_sprites.size():
				player_sprites[i].play("Green")
			ANI_idle = "wakizashi_idle"
			ANI_attack_1 = "wakizashi_attack_1"
			ANI_attack_2 = "wakizashi_attack_2"
			ANI_block = "wakizashi_block"
			ANI_dodge = "wakizashi_dodge"
			ANI_special = "wakizashi_special"
			ANI_staggered = "wakizashi_staggered"
		
		"great_sword":
			$Player_Parts/Upper_Right/R_Weapons/Great_Sword.visible = true
			for i in player_sprites.size():
				player_sprites[i].play("White")
			ANI_idle = "great_sword_idle"
			ANI_attack_1 = "great_sword_attack_1"
			ANI_attack_2 = "great_sword_attack_2"
			ANI_block = "great_sword_block"
			ANI_stagger = "great_sword_stagger"
			ANI_dodge = "great_sword_dodge"
			ANI_special = "great_sword_special"
			ANI_staggered = "great_sword_staggered"
	
	dodge_range = speed * 2.5



func _ready():
#	if Global.fase == "Fase_1":
#		$Camera2D.current = true
#	else:
#		$Camera2D.current = false
	
	_weapon_set()
	$AnimationPlayerUpper.play(ANI_idle)
	$AnimationPlayerLower.play("idle")
	for i in weapon_collisions.size():
		weapon_collisions[i].disabled = true


func _physics_process(delta):
	if Global.life > 0:
		velocity = Vector2.ZERO
		_weapon_set()
		
		
		if Input.is_action_just_pressed("medkit"):
			if Global.medKit > 0 && Global.life <= 90:
				Global.medKit -=1
				Global.life += 60
				$audio_medkit.play()
		
		
		
		if staggered == true:
			$AnimationPlayerUpper.stop()
			$AnimationPlayerLower.stop()
			$AnimationPlayerFull.play(ANI_staggered)
			block = false
			dodge = false
			attack = false
			stagger = false
			$audio_walk.stop()
		else:
			if dodge == false && jump == false:
				if Input.is_action_pressed("ui_right"):
					flip = false
					moveRight = true
					velocity.x += speed
					$AnimationPlayerLower.play("walk")
					$RayCasts/Right.enabled = true
				else:
					moveRight = false
					$RayCasts/Right.enabled = false
				
				if Input.is_action_pressed("ui_left"):
					flip = true
					moveLeft = true
					velocity.x -= speed
					$AnimationPlayerLower.play("walk")
					$RayCasts/Left.enabled = true
				else:
					moveLeft = false
					$RayCasts/Left.enabled = false
				
				if Global.fase == "Fase_1" || Global.fase == "Fase_3" || Global.fase == "Fase_4" || Global.fase == "Fase_6":
					if Input.is_action_pressed("ui_up"):
						moveUp = true
						velocity.y -= speed
						$AnimationPlayerLower.play("walk")
						$RayCasts/Up.enabled = true
					else:
						moveUp = false
						$RayCasts/Up.enabled = false
					
					if Input.is_action_pressed("ui_down"):
						moveDown = true
						velocity.y += speed
						$AnimationPlayerLower.play("walk")
						$RayCasts/Down.enabled = true
					else:
						moveDown = false
						$RayCasts/Down.enabled = false
				if Global.fase == "Fase_2":
					if Input.is_action_just_pressed("space"):
						if grounded == true:
							jump = true
							grounded = false
							$audio_jump.play()
			
			
			
			
			if Input.is_action_just_pressed("katana"):
				Global.weapon = "katana"
				for i in weapon_collisions.size():
					weapon_collisions[i].disabled = true
				_weapon_set()
			if Input.is_action_just_pressed("hammer"):
				Global.weapon = "hammer"
				for i in weapon_collisions.size():
					weapon_collisions[i].disabled = true
				_weapon_set()
			if Input.is_action_just_pressed("katar"):
				Global.weapon = "katar"
				for i in weapon_collisions.size():
					weapon_collisions[i].disabled = true
				_weapon_set()
			
			
			
			
			
			
			if Input.is_action_just_pressed("attack"):
				if block == false && stagger == false && dodge == false && special == false:
					if attack == false:
						attack = true
						if attackVar == false:
							attackVar = true
						else:
							attackVar = false
			
			if Input.is_action_pressed("block"):
				if Global.weapon == "katana" || Global.weapon == "axe" || Global.weapon == "wakizashi" || Global.weapon == "greatsword":
					if attack == false && stagger == false && dodge == false && special == false:
						if Global.stamina > 0:
							block = true
							Global.block = true
						else:
							block = false
							Global.block = false
			else:
				block = false
				Global.block = false
			if Input.is_action_pressed("stagger"):
				if Global.weapon == "hammer" || Global.weapon == "axe" || Global.weapon == "tonfa" || Global.weapon == "greatsword":
					if attack == false && block == false && dodge == false && special == false:
						match Global.weapon:
							"hammer":
								if Global.stamina >= 33:
									stagger = true
			if Input.is_action_just_pressed("dodge"):
				if Global.weapon == "katar" || Global.weapon == "tonfa" || Global.weapon == "wakizashi" || Global.weapon == "greatsword":
					if attack == false && block == false && stagger == false && special == false:
						match Global.weapon:
							"katar":
								if Global.stamina >= 15:
									Global.stamina -= 15
									dodge = true
			if Input.is_action_pressed("special"):
				if Global.weapon == "axe" || Global.weapon == "tonfa" || Global.weapon == "wakizashi" || Global.weapon == "greatsword":
					if attack == false && block == false && stagger == false && dodge == false:
						special = true
			
			
			if jump == true:
				velocity.y -= jumpForce
				$AnimationPlayerLower.play("jump")
			elif moveRight == false && moveLeft == false && moveUp == false && moveDown == false:
				$AnimationPlayerLower.play("idle")
				$audio_walk.stop()
				if Global.fase == "Fase_2":
					velocity.y += gravity
			else:
				if $audio_walk.playing == false:
					$audio_walk.play()
				if Global.fase == "Fase_2":
					velocity.y += gravity
			
			if dodge == true:
				$AnimationPlayerFull.play(ANI_dodge)
				#set_collision_layer_bit(1, false)
				#set_collision_mask_bit(2,false)
				if flip == false:
					velocity.x += dodge_range
				else:
					velocity.x -= dodge_range
			elif block == true:
				speed = 100
				if $AnimationPlayerUpper.current_animation != ANI_block && $AnimationPlayerUpper.current_animation != ANI_block_b1 && $AnimationPlayerUpper.current_animation != ANI_block_b2:
					$AnimationPlayerUpper.play(ANI_block)
			elif stagger == true:
				$AnimationPlayerUpper.play(ANI_stagger)
				attackVar = true
			elif attack == true:
				if attackVar == false:
					$AnimationPlayerUpper.play(ANI_attack_1)
				else:
					$AnimationPlayerUpper.play(ANI_attack_2)
			else:
				$AnimationPlayerUpper.play(ANI_idle)
		
		
		Global.dodge = dodge
		staggered = Global.staggered
		Global.flip = flip
		Global.block = block
		
		
		
		
		if Global.fase == "Fase_1" || Global.fase == "Fase_3" || Global.fase == "Fase_4" || Global.fase == "Fase_6":
			velocity = velocity.normalized()
			if dodge == false:
				move_and_slide(velocity * speed)
			else:
				move_and_slide(velocity * dodge_range)
			
			
		if Global.fase == "Fase_2":
			velocity = velocity.normalized()
			if dodge == false && jump == false:
				move_and_slide(velocity * speed)
			elif dodge == true:
				move_and_slide(velocity * dodge_range)
			elif jump == true:
				velocity.x -= 0.5
				move_and_slide(velocity * jumpForce)
			if jump == false:
				move_and_slide(velocity * gravity)
		
		
		
		
		if $RayCasts/Right.is_colliding():
			var enemy = $RayCasts/Right.get_collider()
			enemy.move_and_slide(Vector2(15, 0) * speed * delta)
		if $RayCasts/Left.is_colliding():
			var enemy = $RayCasts/Left.get_collider()
			enemy.move_and_slide(Vector2(-15, 0) * speed * delta)
		if $RayCasts/Up.is_colliding():
			var enemy = $RayCasts/Up.get_collider()
			enemy.move_and_slide(Vector2(0, -15) * speed * delta)
		if $RayCasts/Down.is_colliding():
			var enemy = $RayCasts/Down.get_collider()
			enemy.move_and_slide(Vector2(0, 15) * speed * delta)
		
		
		
		for area in $Area2D_Ground.get_overlapping_areas():
			layer = LAYER._get_layer(area.name, layer)
			z_index = LAYER._get_z_index(area.name, z_index)
			if area.name == "Area2D_Ground":
				grounded = true
#				$audio_fall.play()
		LAYER.playerLayer = layer
	else:
		if Global.dead == false:
			$AnimationPlayerUpper.stop()
			$AnimationPlayerLower.stop()
			if dead_var == false:
				$AnimationPlayerFull.play(ANI_dead)
			Global.dead = true





func _on_TimerFlip_timeout():
	if flip == false:
		for i in player_parts.size():
			player_parts[i].position.x *= 1
			player_parts[i].rotation_degrees *= 1
		for i in player_sprites.size():
			player_sprites[i].flip_h = false
		for i in weapons.size():
			weapons[i].position.x *= 1
			weapons[i].rotation_degrees *= 1
			#$Player_Parts/Katana/Blade.flip_h = false
		$Area2D_Block/Collision_Block.position.x = 20
			
	else:
		for i in player_parts.size():
			player_parts[i].position.x *= -1
			player_parts[i].rotation_degrees *= -1
		for i in player_sprites.size():
			player_sprites[i].flip_h = true
		for i in weapons.size():
			weapons[i].position.x *= -1
			weapons[i].rotation_degrees *= -1
		for i in weapons_sprites.size():
			weapons_sprites[i].flip_h = true
		$Area2D_Block/Collision_Block.position.x *= -1


func _on_Area2D_Ground_area_entered(area):
	layer = LAYER._get_layer(area.name, layer)
	z_index = LAYER._get_z_index(area.name, z_index)
	LAYER.playerLayer = layer
#	if area.name == "Area2D_Ground":
#		$audio_fall.play()


func _on_Area2D_Ground_area_exited(area):
	if area.name == "Area2D_Ground":
		grounded = false



func _on_Area2D_Block_area_entered(area):
	if Global.blocked == true:
		if block == true:
			if blockVar == false:
				$AnimationPlayerUpper.play(ANI_block_b1)
				$audio_block_1.play()
				blockVar = true
			else:
				$AnimationPlayerUpper.play(ANI_block_b2)
				$audio_block_2.play()
				blockVar = false
			Global.blocked = false


func _on_AnimationPlayerFull_animation_finished(anim_name):
	if Global.life <= 0:
		if Global.dead == true:
			$TimerFlip.queue_free()
			$AnimationPlayerFull.queue_free()


func _on_Timer_Dead_timeout():
	get_tree().change_scene("res://assets/interfaces/game_over.tscn")





func _on_Area2D_Player_area_entered(area):
	if area.name == "Area2D_outdoor":
		dead_var = true
		if Global.life > 0:
			Global.life = 0
			$AnimationPlayerFull.play("Dead_outdoor")
