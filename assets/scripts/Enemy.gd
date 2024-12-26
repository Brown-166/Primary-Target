extends Character
class_name Enemy


var life : int
var S : Array
var speed : int
var velocity = Vector2.ZERO


var OP : Array
var option : int
var WO : Array
var weapon_option

var DMG : Array = ["Head_1", "Head_2", "Chest", "L_Arm", "R_Arm", "L_Leg", "R_Leg"]
var damage : String
var ADMG : Array
var audio_dmg : int
var audio

var DEAD : Array
var dead : int


var max_ammo : int
var ammo : int


var action : String = "stop"
var pushed : bool = false


var layer : Array = [0, 0]
var staggered = false
var target = null

var MEDKIT = preload("res://assets/objects/medKit.tscn")
var MD : Array
var med_drop : int



func _init(l:int, ma:int, s:Array, op:Array, wo:Array, admg:Array, d:Array, md:Array):
	life = l 
	max_ammo = ma
	ammo = max_ammo
	
	S = s
	OP = op
	WO = wo
	ADMG = admg
	DEAD = d
	MD = md
	
	randomize()
	speed = S[randi() % S.size()]
	option = OP[randi() % OP.size()]
	weapon_option = WO[randi() % WO.size()]



func _physics(delta, s:KinematicBody2D, ground_0:Area2D,  ground_1:Area2D, ray_R:RayCast2D, 
ray_L:RayCast2D, ray_U:RayCast2D, ray_D:RayCast2D):
	if life > 0:
		for area in ground_0.get_overlapping_areas():
			layer[0] = LAYER._get_layer(area.name, layer[0])
			s.z_index = LAYER._get_z_index(area.name, s.z_index)
		for area in ground_1.get_overlapping_areas():
			layer[1] = LAYER._get_layer(area.name, layer[1])
		
		if staggered == false:
			if life > 0:
				if Global.dodge == true:
					s.set_collision_layer_bit(2, false)
					s.set_collision_mask_bit(1, false)
				else:
					s.set_collision_layer_bit(2, true)
					s.set_collision_mask_bit(1, true)
				
				
				
				if ray_R.is_colliding():
					pushed = true
					s.position.x -= 1
				elif ray_L.is_colliding():
					pushed = true
					s.position.x += 1
				elif ray_U.is_colliding():
					pushed = true
					s.position.y += 1
				elif ray_D.is_colliding():
					pushed = true
					s.position.y -= 1
				else:
					pushed = false
				
				
				
				if target:
					if s.global_position.x >= target.global_position.x:
						if action != "flee":
							flip = true
						else:
							flip = false
					if s.global_position.x <= target.global_position.x:
						if action != "flee":
							flip = false
						else:
							flip = true
					
					if action == "follow":
						if pushed == false:
							velocity = s.global_position.direction_to(target.global_position)
							s.move_and_collide(velocity * speed * delta)
					if action == "flee":
						velocity = -(s.global_position.direction_to(target.global_position))
						s.move_and_collide(velocity * speed * delta)
	else:
		s.set_collision_layer_bit(2, false)
		s.set_collision_mask_bit(1, false)


func _set_animation(animL:AnimationPlayer, animU:AnimationPlayer, animF:AnimationPlayer, 
aud_walk:AudioStreamPlayer2D, idle_anim:String, aim_anim:String, attack_anim:String, 
reload_anim:String, staggered_anim:String):
	if staggered == true:
		animL.stop()
		animU.stop()
		animF.play(staggered_anim)
		aud_walk.stop()
	else:
		if life > 0:
			if action in ["follow", "flee"]:
				animL.play("walk")
				if aud_walk.playing == false:
					aud_walk.play()
			else: 
				animL.play("idle")
				aud_walk.stop()
			
			
			if not action in ["aim", "attack", "reload"]:
				animU.play(idle_anim)
			if action == "aim":
				if animU.current_animation != aim_anim:
					animU.play(aim_anim)
			elif action == "attack" && ammo > 0:
				if animU.current_animation != attack_anim:
					animU.play(attack_anim)
			elif action == "reload":
				if animU.current_animation != reload_anim:
					animU.play(reload_anim)
		else:
			animL.stop()
			animU.stop()



func _animation_over(anim):
	if anim == "staggered":
		staggered = false
		
	if anim == "aim":
		if ammo > 0:
			action = "attack"
		else:
			action = "reload"
	if anim == "attack":
		ammo -= 1
		if ammo <= 0:
			action = "reload"
	if anim == "reload":
		ammo = max_ammo
		action = "attack"



func _DMG(au1:AudioStreamPlayer2D, au2:AudioStreamPlayer2D, au3:AudioStreamPlayer2D,
au4:AudioStreamPlayer2D):
	for i in body_parts.size():
		if body_parts[i].name == "Head_DMG":
			if body_parts[i].animation == "default":
				randomize()
				damage = DMG[randi() % DMG.size()]
			else:
				while damage == "Head_1" || damage == "Head_2":
					randomize()
					damage = DMG[randi() % DMG.size()]
	
	randomize()
	audio_dmg = ADMG[randi() % ADMG.size()]
	match audio_dmg:
		1:
			au1.play()
		2:
			au2.play()
		3:
			au3.play()
		4:
			au4.play()
	
	
	for i in body_parts.size():
		match damage:
			"R_Leg":
				if body_parts[i].name == "R_Thigh_DMG":
					body_parts[i].play("option_1")
				if body_parts[i].name == "R_Leg_DMG":
					body_parts[i].play("option_1")
			"L_Leg":
				if body_parts[i].name == "L_Thigh_DMG":
					body_parts[i].play("option_1")
				if body_parts[i].name == "L_Leg_DMG":
					body_parts[i].play("option_1")
			"R_Arm":
				if body_parts[i].name == "R_Arm_DMG":
					body_parts[i].play("option_1")
				if body_parts[i].name == "R_Forearm_DMG":
					body_parts[i].play("option_1")
			"L_Arm":
				if body_parts[i].name == "L_Arm_DMG":
					body_parts[i].play("option_1")
				if body_parts[i].name == "L_Forearm_DMG":
					body_parts[i].play("option_1")
			"Chest":
				if body_parts[i].name == "Chest_DMG":
					body_parts[i].play("option_1")
			"Head_1":
				if body_parts[i].name == "Head_DMG":
					body_parts[i].play("option_1")
			"Head_2":
				if body_parts[i].name == "Head_DMG":
					body_parts[i].play("option_2")


func _dead(animF:AnimationPlayer, ground, s:KinematicBody2D, area:Area2D,
dead_1:String, dead_2:String, dead_3:String, dead_staggered:String):
	action = "dead"
	
	area.queue_free()
	
	if staggered == false:
		randomize()
		dead = DEAD[randi() % DEAD.size()]
		match dead:
			1:
				animF.play(dead_1)
			2:
				animF.play(dead_2)
			3:
				animF.play(dead_3)
	else:
		staggered = false
		animF.play(dead_staggered)
	
	
	randomize()
	med_drop = MD[randi() % MD.size()]
	if med_drop == 1:
		var medkit = MEDKIT.instance()
		medkit._set_layer(layer)
		s.get_parent().add_child(medkit)
		medkit.z_as_relative = false
		medkit.position = ground.global_position



func _take_dmg(area:Area2D, cut_1:AudioStreamPlayer2D, cut_2:AudioStreamPlayer2D,
 smash:AudioStreamPlayer2D, au1:AudioStreamPlayer2D, au2:AudioStreamPlayer2D, 
au3:AudioStreamPlayer2D, au4:AudioStreamPlayer2D):
	if layer[0] in LAYER.playerLayer || layer[1] in LAYER.playerLayer:
		match area.name:
			"Area2D_Katana":
				cut_1.play()
				life -= Global.katana_DMG
				_DMG(au1, au2, au3, au4)
			"Area2D_Hammer":
				smash.play()
				life -= Global.hammer_DMG
				_DMG(au1, au2, au3, au4)
			"Area2D_Hammer_stagger":
				smash.play()
				life -= Global.hammer_DMG/3
				staggered = true
				_DMG(au1, au2, au3, au4)
			"Area2D_Katar":
				cut_2.play()
				life -= Global.katar_DMG
				_DMG(au1, au2, au3, au4)



func _follow(body):
	if body.name == "Player" && life > 0:
		target = body
		action = "follow"



func _stop(body):
	if body.name == "Player" && life > 0:
		if not action in ["aim", "attack", "reload"]:
			action = "aim"
