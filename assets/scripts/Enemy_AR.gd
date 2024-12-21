extends KinematicBody2D

var enemy_ar = Enemy.new(100, 40, [100, 100, 125, 125, 150, 150, 175, 175, 185],
[1, 2, 3, 4], [1, 2], [1, 2, 3, 4], [1,2,3], [1, 2, 3, 4, 5])


const BULLET = preload("res://assets/objects/AR_bullet.tscn")


onready var weapon = [$Body/Chest/R_Arm/R_Forearm/R_Hand/weapon, 
$Body/Chest/R_Arm/R_Forearm/R_Hand/weapon/reloader]






func _ready():
	enemy_ar._set_body($Body)
	match enemy_ar.option:
		1:
			for i in enemy_ar.body_parts.size():
				if enemy_ar.body_parts[i].get_class() == "AnimatedSprite":
					enemy_ar.body_parts[i].play("option_1")
		2:
			for i in enemy_ar.body_parts.size():
				if enemy_ar.body_parts[i].get_class() == "AnimatedSprite":
					enemy_ar.body_parts[i].play("option_2")
		3:
			for i in enemy_ar.body_parts.size():
				if enemy_ar.body_parts[i].get_class() == "AnimatedSprite":
					enemy_ar.body_parts[i].play("option_3")
		4:
			for i in enemy_ar.body_parts.size():
				if enemy_ar.body_parts[i].get_class() == "AnimatedSprite":
					enemy_ar.body_parts[i].play("option_4")
	
	for i in enemy_ar.body_parts.size():
		if enemy_ar.body_parts[i].name in ["Head_DMG", "Chest_DMG", "R_Arm_DMG", 
		"R_Forearm_DMG","L_Arm_DMG", "L_Forearm_DMG", "R_Thigh_DMG", "R_Leg_DMG", 
		"L_Thigh_DMG", "L_Leg_DMG"]:
			enemy_ar.body_parts[i].play("default")
	
	
	match enemy_ar.weapon_option:
		1:
			weapon[0].play("AK-47")
			weapon[1].play("AK-47")
		2:
			weapon[0].play("M-16")
			weapon[1].play("M-16")
	


func _physics_process(delta):
	enemy_ar._physics(delta, self, $Body/Animation_Lower, $Body/Animation_Upper, 
	$Body/Animation_Full, $Area2D_Ground_0, $Area2D_Ground_1, $audio_walk, $audio_shoot, 
	$audio_reload, $Timer_Shoot, $RayCasts/Right, $RayCasts/Left, $RayCasts/Up, 
	$RayCasts/Down)
	enemy_ar._flip($Body)





func _on_Area2D_Enemy_AR_area_entered(area):
	enemy_ar._take_dmg(area, $audio_cut_dmg_1, $audio_cut_dmg_2, $audio_smash_dmg_1, 
	$audio_dmg_1, $audio_dmg_2, $audio_dmg_3, $audio_dmg_4)
	if area.name in ["Area2D_Katana", "Area2D_Hammer", "Area2D_Hammer_stagger", 
	"Area2D_Katar"]:
		if enemy_ar.layer[0] in LAYER.playerLayer || enemy_ar.layer[1] in LAYER.playerLayer:
			enemy_ar.action = "flee"
	if enemy_ar.life <= 0:
		enemy_ar._dead($Body/Animation_Full, $Area2D_Ground_0/CollisionShape2D, self, 
		$Area2D_Enemy_AR)


func _on_Area2D_Follow_body_entered(body):
	enemy_ar._follow(body)


func _on_Area2D_Follow_body_exited(body):
	enemy_ar._follow(body)


func _on_Area2D_Stop_body_entered(body):
	enemy_ar._stop(body)


func _on_Area2D_Stop_body_exited(body):
	enemy_ar._stop(body)


func _on_Animation_Full_animation_finished(anim_name):
	enemy_ar._animation_over(anim_name)


func _on_Animation_Upper_animation_finished(anim_name):
	enemy_ar._animation_over(anim_name)
	if anim_name == "attack":
		$audio_shoot.play()
		var bulletInstance = BULLET.instance()
		bulletInstance._set_layer(enemy_ar.layer)
		if enemy_ar.flip == false:
			get_parent().add_child(bulletInstance)
			bulletInstance.position = $PositionRight.global_position
			bulletInstance._set_direction(1)
		else:
			get_parent().add_child(bulletInstance)
			bulletInstance.position = $PositionLeft.global_position
			bulletInstance._set_direction(-1)
		


func _on_Animation_Lower_animation_finished(anim_name):
	enemy_ar._animation_over(anim_name)
