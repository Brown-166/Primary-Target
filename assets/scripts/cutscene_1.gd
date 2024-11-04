extends Node2D

export var enemy_ar_flip : bool
onready var enemy_ar_parts = [
	$Enemy_AR/Upper_Right/Head, $Enemy_AR/Upper_Right/Chest, 
	$Enemy_AR/Upper_Right/R_Arm, $Enemy_AR/Upper_Right/R_Forearm, $Enemy_AR/Upper_Right/R_Forearm/R_Hand, 
	$Enemy_AR/Upper_Left/L_Arm, $Enemy_AR/Upper_Left/L_Forearm, $Enemy_AR/Upper_Left/L_Forearm/L_Hand, 
	$Enemy_AR/Lower/R_Thigh, $Enemy_AR/Lower/R_Leg, $Enemy_AR/Lower/R_Leg/R_Foot,
	$Enemy_AR/Lower/L_Thigh, $Enemy_AR/Lower/L_Leg, $Enemy_AR/Lower/L_Leg/L_Foot,
	$Enemy_AR/Upper_Right/Weapon_Set, $Enemy_AR/Upper_Right/Weapon_Set/Weapon, 
	$Enemy_AR/Upper_Right/Weapon_Set/Reloader, 
	$Enemy_AR/Upper_Right/Weapon_Set/Fire]
onready var enemy_ar_sprites = [
	$Enemy_AR/Upper_Right/Head/Sprite, $Enemy_AR/Upper_Right/Chest/Sprite, 
	$Enemy_AR/Upper_Right/R_Arm/Sprite, $Enemy_AR/Upper_Right/R_Forearm/Sprite, $Enemy_AR/Upper_Right/R_Forearm/R_Hand/Sprite, 
	$Enemy_AR/Upper_Left/L_Arm/Sprite, $Enemy_AR/Upper_Left/L_Forearm/Sprite, $Enemy_AR/Upper_Left/L_Forearm/L_Hand/Sprite, 
	$Enemy_AR/Lower/R_Thigh/Sprite, $Enemy_AR/Lower/R_Leg/Sprite, $Enemy_AR/Lower/R_Leg/R_Foot/Sprite,
	$Enemy_AR/Lower/L_Thigh/Sprite, $Enemy_AR/Lower/L_Leg/Sprite, $Enemy_AR/Lower/L_Leg/L_Foot/Sprite,
	$Enemy_AR/Upper_Right/Weapon_Set/Weapon/Sprite, 
	$Enemy_AR/Upper_Right/Weapon_Set/Reloader/Sprite, 
	$Enemy_AR/Upper_Right/Weapon_Set/Fire/Sprite]
var enemy_ar_or_position_x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 
	14, 15, 16, 17]

export var hades_flip : bool
onready var hades_parts = [
	$Hades/Upper_Right, $Hades/Upper_Left, $Hades/Lower,
	$Hades/Upper_Right/Head, $Hades/Upper_Right/Chest,
	$Hades/Upper_Right/R_Arm, $Hades/Upper_Right/R_Arm/R_Forearm, $Hades/Upper_Right/R_Arm/R_Forearm/R_Hand,
	$Hades/Upper_Left/L_Arm, $Hades/Upper_Left/L_Arm/L_Forearm, $Hades/Upper_Left/L_Arm/L_Forearm/L_Hand,
	$Hades/Lower/R_Thigh, $Hades/Lower/R_Thigh/R_Leg, $Hades/Lower/R_Thigh/R_Leg/R_Foot,
	$Hades/Lower/L_Thigh, $Hades/Lower/L_Thigh/L_Leg, $Hades/Lower/L_Thigh/L_Leg/L_Foot]
onready var hades_sprites = [
	$Hades/Upper_Right/Head, $Hades/Upper_Right/Chest,
	$Hades/Upper_Right/R_Arm, $Hades/Upper_Right/R_Arm/R_Forearm, $Hades/Upper_Right/R_Arm/R_Forearm/R_Hand,
	$Hades/Upper_Left/L_Arm, $Hades/Upper_Left/L_Arm/L_Forearm, $Hades/Upper_Left/L_Arm/L_Forearm/L_Hand,
	$Hades/Lower/R_Thigh, $Hades/Lower/R_Thigh/R_Leg, $Hades/Lower/R_Thigh/R_Leg/R_Foot,
	$Hades/Lower/L_Thigh, $Hades/Lower/L_Thigh/L_Leg, $Hades/Lower/L_Thigh/L_Leg/L_Foot]
var hades_or_position_x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]

export var boss_blue_flip : bool
onready var boss_blue_parts = [
	$Boss_Blue/Upper_Right, $Boss_Blue/Upper_Left, $Boss_Blue/Lower,
	$Boss_Blue/Upper_Right/Head, $Boss_Blue/Upper_Right/Chest,
	$Boss_Blue/Upper_Right/R_Arm, $Boss_Blue/Upper_Right/R_Arm/R_Forearm, $Boss_Blue/Upper_Right/R_Arm/R_Forearm/R_Hand,
	$Boss_Blue/Upper_Left/L_Arm, $Boss_Blue/Upper_Left/L_Arm/L_Forearm, $Boss_Blue/Upper_Left/L_Arm/L_Forearm/L_Hand,
	$Boss_Blue/Lower/R_Thigh, $Boss_Blue/Lower/R_Thigh/R_Leg, $Boss_Blue/Lower/R_Thigh/R_Leg/R_Foot,
	$Boss_Blue/Lower/L_Thigh, $Boss_Blue/Lower/L_Thigh/L_Leg, $Boss_Blue/Lower/L_Thigh/L_Leg/L_Foot,
	$Boss_Blue/Upper_Right/Katar, $Boss_Blue/Upper_Left/Katar]
onready var boss_blue_sprites = [
	$Boss_Blue/Upper_Right/Head/Sprite, $Boss_Blue/Upper_Right/Chest/Sprite,
	$Boss_Blue/Upper_Right/R_Arm/Sprite, $Boss_Blue/Upper_Right/R_Arm/R_Forearm/Sprite, $Boss_Blue/Upper_Right/R_Arm/R_Forearm/R_Hand/Sprite,
	$Boss_Blue/Upper_Left/L_Arm/Sprite, $Boss_Blue/Upper_Left/L_Arm/L_Forearm/Sprite, $Boss_Blue/Upper_Left/L_Arm/L_Forearm/L_Hand/Sprite,
	$Boss_Blue/Lower/R_Thigh/Sprite, $Boss_Blue/Lower/R_Thigh/R_Leg/Sprite, $Boss_Blue/Lower/R_Thigh/R_Leg/R_Foot/Sprite,
	$Boss_Blue/Lower/L_Thigh/Sprite, $Boss_Blue/Lower/L_Thigh/L_Leg/Sprite, $Boss_Blue/Lower/L_Thigh/L_Leg/L_Foot/Sprite,
	$Boss_Blue/Upper_Right/Katar/Hilt, $Boss_Blue/Upper_Right/Katar/Blade,
	$Boss_Blue/Upper_Left/Katar/Hilt, $Boss_Blue/Upper_Left/Katar/Blade]
var boss_blue_or_position_x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 
	14, 15, 16, 17, 18, 19]

export var boss_red_flip : bool
onready var boss_red_parts = [
	$Boss_Red/Upper_Right, $Boss_Red/Upper_Left, $Boss_Red/Lower,
	$Boss_Red/Upper_Right/Head, $Boss_Red/Upper_Right/Chest,
	$Boss_Red/Upper_Right/R_Arm, $Boss_Red/Upper_Right/R_Arm/R_Forearm, $Boss_Red/Upper_Right/R_Arm/R_Forearm/R_Hand,
	$Boss_Red/Upper_Left/L_Arm, $Boss_Red/Upper_Left/L_Arm/L_Forearm, $Boss_Red/Upper_Left/L_Arm/L_Forearm/L_Hand,
	$Boss_Red/Lower/R_Thigh, $Boss_Red/Lower/R_Thigh/R_Leg, $Boss_Red/Lower/R_Thigh/R_Leg/R_Foot,
	$Boss_Red/Lower/L_Thigh, $Boss_Red/Lower/L_Thigh/L_Leg, $Boss_Red/Lower/L_Thigh/L_Leg/L_Foot,
	$Boss_Red/Upper_Right/Hammer]
onready var boss_red_sprites = [
	$Boss_Red/Upper_Right/Head/Sprite, $Boss_Red/Upper_Right/Chest/Sprite,
	$Boss_Red/Upper_Right/R_Arm/Sprite, $Boss_Red/Upper_Right/R_Arm/R_Forearm/Sprite, $Boss_Red/Upper_Right/R_Arm/R_Forearm/R_Hand/Sprite,
	$Boss_Red/Upper_Left/L_Arm/Sprite, $Boss_Red/Upper_Left/L_Arm/L_Forearm/Sprite, $Boss_Red/Upper_Left/L_Arm/L_Forearm/L_Hand/Sprite,
	$Boss_Red/Lower/R_Thigh/Sprite, $Boss_Red/Lower/R_Thigh/R_Leg/Sprite, $Boss_Red/Lower/R_Thigh/R_Leg/R_Foot/Sprite,
	$Boss_Red/Lower/L_Thigh/Sprite, $Boss_Red/Lower/L_Thigh/L_Leg/Sprite, $Boss_Red/Lower/L_Thigh/L_Leg/L_Foot/Sprite,
	$Boss_Red/Upper_Right/Hammer/Hilt, $Boss_Red/Upper_Right/Hammer/Head]
var boss_red_or_position_x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 
	14, 15, 16, 17, 18]


func _ready():
	Global.fase = "cutscene_1"
	for i in enemy_ar_parts.size():
		enemy_ar_or_position_x[i] = enemy_ar_parts[i].position.x
	
	for i in hades_parts.size():
		hades_or_position_x[i] = hades_parts[i].position.x
	
	for i in boss_blue_parts.size():
		boss_blue_or_position_x[i] = boss_blue_parts[i].position.x
	
	for i in boss_red_parts.size():
		boss_red_or_position_x[i] = boss_red_parts[i].position.x


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "loading_out":
		get_tree().change_scene("res://assets/scenes/Fase_1.tscn")


func _on_Timer_Flip_timeout():
	if enemy_ar_flip == true:
		for i in enemy_ar_parts.size():
			if enemy_ar_parts[i].position.x == enemy_ar_or_position_x[i]:
				enemy_ar_parts[i].position.x *= -1
				enemy_ar_parts[i].rotation_degrees *= -1
		for i in enemy_ar_sprites.size():
			enemy_ar_sprites[i].flip_h = true
	else:
		for i in enemy_ar_sprites.size():
			enemy_ar_sprites[i].flip_h = false
	
	
	if hades_flip == true:
		for i in hades_parts.size():
			if hades_parts[i].position.x == hades_or_position_x[i]:
				hades_parts[i].position.x *= -1
				hades_parts[i].rotation_degrees *= -1
		for i in hades_sprites.size():
			hades_sprites[i].flip_h = true
	else:
		for i in hades_sprites.size():
			hades_sprites[i].flip_h = false
	
	
	if boss_blue_flip == true:
		for i in boss_blue_parts.size():
			if boss_blue_parts[i].position.x == boss_blue_or_position_x[i]:
				boss_blue_parts[i].position.x *= -1
				boss_blue_parts[i].rotation_degrees *= -1
		for i in boss_blue_sprites.size():
			boss_blue_sprites[i].flip_h = true
	else:
		for i in boss_blue_sprites.size():
			boss_blue_sprites[i].flip_h = false
	
	
	if boss_red_flip == true:
		for i in boss_red_parts.size():
			if boss_red_parts[i].position.x == boss_red_or_position_x[i]:
				boss_red_parts[i].position.x *= -1
				boss_red_parts[i].rotation_degrees *= -1
		for i in boss_red_sprites.size():
			boss_red_sprites[i].flip_h = true
	else:
		for i in boss_red_sprites.size():
			boss_red_sprites[i].flip_h = false
