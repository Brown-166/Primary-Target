extends KinematicBody2D

var body = Character.new()

var velocity = Vector2.ZERO
var speed = 200
var jumpForce = speed * 5
var gravity = speed * 5
var layer : Array = [0, 0]
var grounded = false
var moveRight = false
var moveLeft = false
var moveUp = false
var moveDown = false
var jump = false

var attack = false
var attackVar = true
var block = false
var blockVar = false
var stagger = false
var staggered = false
var dodge = false
var dodge_range = speed * 4


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



func _weapon_set():
	match Global.weapon:
		"katana":
			for i in body.body_parts.size():
				if body.body_parts[i].get_class() == "AnimatedSprite":
					body.body_parts[i].play("yellow")
			ANI_idle = "katana_idle"
			ANI_attack_1 = "katana_attack_1"
			ANI_attack_2 = "katana_attack_2"
			ANI_block = "katana_blocking"
			ANI_block_b1 = "katana_blocked_1"
			ANI_block_b2 = "katana_blocked_2"
			ANI_staggered = "katana_staggered"
			ANI_dead = "katana_dead"
			$Body/Animation_Upper.playback_speed = 1
			speed = 200
		"hammer":
			for i in body.body_parts.size():
				if body.body_parts[i].get_class() == "AnimatedSprite":
					body.body_parts[i].play("red")
			ANI_idle = "hammer_idle"
			ANI_attack_1 = "hammer_attack_1"
			ANI_attack_2 = "hammer_attack_2"
			ANI_stagger = "hammer_stagger"
			ANI_staggered = "hammer_staggered"
			ANI_dead = "hammer_dead"
			$Body/Animation_Upper.playback_speed = 0.6
			speed = 150
		
		"katar":
			for i in body.body_parts.size():
				if body.body_parts[i].get_class() == "AnimatedSprite":
					body.body_parts[i].play("blue")
			ANI_idle = "katar_idle"
			ANI_attack_1 = "katar_attack_1"
			ANI_attack_2 = "katar_attack_2"
			ANI_dodge = "katar_dodge"
			ANI_staggered = "katar_staggered"
			ANI_dead = "katar_dead"
			$Body/Animation_Upper.playback_speed = 2
			speed = 250
	
	dodge_range = speed * 2.5



func _hit():
	if Global.hit == "bullet":
		if $audio_dmg_1.playing == false:
			$audio_dmg_1.play()
			Global.hit = ""
	if Global.hit == "attack":
		if $audio_dmg_2.playing == false:
			$audio_dmg_2.play()
			Global.hit = ""
	if block == true && Global.blocked == true:
		Global.blocked = false
		if blockVar == false:
			$Body/Animation_Upper.play("katana_blocked_1")
			blockVar = true
		else:
			$Body/Animation_Upper.play("katana_blocked_2")
			blockVar = false


func _ready():
	body._set_body($Body)
	_weapon_set()
	$Body/Animation_Upper.play(ANI_idle)
	$Body/Animation_Lower.play("idle")


func _physics_process(delta):
	if Global.life > 0:
		velocity = Vector2.ZERO
		body._flip($Body)
		_weapon_set()
		_hit()
		
		
		if Input.is_action_just_pressed("medkit"):
			if Global.medKit > 0 && Global.life <= 90:
				Global.medKit -=1
				Global.life += 60
				$audio_medkit.play()
		
		
		
		if staggered == true:
			$Body/Animation_Upper.stop()
			$Body/Animation_Lower.stop()
			$Body/Animation_Full.play(ANI_staggered)
			block = false
			dodge = false
			attack = false
			stagger = false
			$audio_walk.stop()
		else:
			if dodge == false && jump == false:
				if Input.is_action_pressed("ui_right"):
					body.flip = false
					moveRight = true
					velocity.x += speed
					$Body/Animation_Lower.play("walk")
					$RayCasts/Right.enabled = true
				else:
					moveRight = false
					$RayCasts/Right.enabled = false
				
				if Input.is_action_pressed("ui_left"):
					body.flip = true
					moveLeft = true
					velocity.x -= speed
					$Body/Animation_Lower.play("walk")
					$RayCasts/Left.enabled = true
				else:
					moveLeft = false
					$RayCasts/Left.enabled = false
				
				if Global.fase in ["Test", "Fase_1", "Fase_3", "Fase_4", "Fase_6"]:
					if Input.is_action_pressed("ui_up"):
						moveUp = true
						velocity.y -= speed
						$Body/Animation_Lower.play("walk")
						$RayCasts/Up.enabled = true
					else:
						moveUp = false
						$RayCasts/Up.enabled = false
					
					if Input.is_action_pressed("ui_down"):
						moveDown = true
						velocity.y += speed
						$Body/Animation_Lower.play("walk")
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
			
			
			
			
			if attack == false && block == false && stagger == false && dodge == false && staggered == false:
				if Input.is_action_just_pressed("katana"):
					Global.weapon = "katana"
					_weapon_set()
				if Input.is_action_just_pressed("hammer"):
					if Global.arsenal[1] == "hammer":
						Global.weapon = "hammer"
						_weapon_set()
				if Input.is_action_just_pressed("katar"):
					if Global.arsenal[2] == "katar":
						Global.weapon = "katar"
						_weapon_set()
			
			
			
			
			
			
			if Input.is_action_just_pressed("attack"):
				if block == false && stagger == false && dodge == false:
					if attack == false:
						attack = true
						if attackVar == false:
							attackVar = true
						else:
							attackVar = false
			
			if Input.is_action_pressed("block"):
				if Global.weapon == "katana":
					if attack == false && stagger == false && dodge == false:
						if Global.stamina > 0:
							block = true
							Global.block = true
						else:
							block = false
							Global.block = false
			else:
				block = false
				Global.block = false
				Global.blocked = false
			if Input.is_action_pressed("stagger"):
				if Global.weapon == "hammer":
					if attack == false && block == false && dodge == false:
						if Global.stamina >= 33:
							stagger = true
			if Input.is_action_just_pressed("dodge"):
				if Global.weapon == "katar":
					if attack == false && block == false && stagger == false:
						if Global.stamina >= 15:
							Global.stamina -= 15
							dodge = true
			
			
			if jump == true:
				velocity.y -= jumpForce
				$Body/Animation_Lower.play("jump")
			elif moveRight == false && moveLeft == false && moveUp == false && moveDown == false:
				$Body/Animation_Lower.play("idle")
				$audio_walk.stop()
				if Global.fase == "Fase_2":
					velocity.y += gravity
			else:
				if $audio_walk.playing == false:
					$audio_walk.play()
				if Global.fase == "Fase_2":
					velocity.y += gravity
			
			if dodge == true:
				$Body/Animation_Full.play(ANI_dodge)
				if body.flip == false:
					velocity.x += dodge_range
				else:
					velocity.x -= dodge_range
			elif block == true:
				speed = 100
				if not $Body/Animation_Upper.current_animation in [ANI_block, ANI_block_b1, ANI_block_b2]:
					$Body/Animation_Upper.play(ANI_block)
			elif stagger == true:
				$Body/Animation_Upper.play(ANI_stagger)
				attackVar = true
			elif attack == true:
				if attackVar == false:
					$Body/Animation_Upper.play(ANI_attack_1)
				else:
					$Body/Animation_Upper.play(ANI_attack_2)
			else:
				$Body/Animation_Upper.play(ANI_idle)
		
		
		
		
		if Global.fase in ["Test","Fase_1", "Fase_3", "Fase_4", "Fase_6"]:
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
		
		
		
		for area in $Area2D_Ground_0.get_overlapping_areas():
			layer[0] = LAYER._get_layer(area.name, layer[0])
			z_index = LAYER._get_z_index(area.name, z_index)
			if area.name == "Area2D_Ground":
				grounded = true
		for area in $Area2D_Ground_1.get_overlapping_areas():
			layer[1] = LAYER._get_layer(area.name, layer[1])
		
		
		LAYER.playerLayer = layer
		Global.dodge = dodge
		staggered = Global.staggered
		Global.flip = body.flip
		Global.block = block
	else:
		if Global.dead == false:
			$Body/Animation_Upper.stop()
			$Body/Animation_Lower.stop()
			if dead_var == false:
				$Body/Animation_Full.play(ANI_dead)
			Global.dead = true
			DB._save_new_game(DB.current_save)





func _on_Area2D_Ground_0_area_exited(area):
	if area.name == "Area2D_Ground":
		grounded = false



func _on_Area2D_Player_area_entered(area):
	if area.name == "Area2D_outdoor":
		dead_var = true
		if Global.life > 0:
			Global.life = 0
			$Body/Animation_Full.play("dead_outdoor")


func _on_Animation_Upper_animation_finished(anim_name):
	if anim_name in [ANI_attack_1, ANI_attack_2]:
		attack = false
	if anim_name == ANI_stagger:
		stagger = false
		Global.stamina -= 33

func _on_Animation_Lower_animation_finished(anim_name):
	if anim_name == "jump":
		jump = false


func _on_Animation_Full_animation_finished(anim_name):
	if anim_name == ANI_dodge:
		dodge = false
	if anim_name == ANI_staggered:
		Global.staggered = false
		staggered = false
	if Global.life <= 0:
		if Global.dead == true:
			$Timer_Dead.start()


func _on_Timer_Dead_timeout():
	get_tree().change_scene("res://assets/interfaces/game_over.tscn")
