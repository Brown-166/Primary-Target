extends KinematicBody2D

var enemy = Enemy.new(300, 1000, [150], [1], [1], [0], [1], [1])

var blocked = false

var ST = [3, 4, 4, 5]

var stagger_attack = true

var area_player = false

func _ready():
	enemy._set_body($Body)
	$Body/Animation_Lower.playback_speed = 0.6
	$Body/Animation_Upper.playback_speed = 0.6


func _physics_process(delta):
	enemy._physics(delta, self, $Area2D_Ground_0, $Area2D_Ground_1, $RayCasts/Right, 
	$RayCasts/Left, $RayCasts/Up, $RayCasts/Down)
	if not enemy.action in ["attack", "reload"]:
		enemy._flip($Body)
	enemy._set_animation($Body/Animation_Lower, $Body/Animation_Upper, 
	$Body/Animation_Full, $audio_walk, "hammer_idle", "", "hammer_attack_1", 
	"hammer_attack_2", "hammer_stagger", "hammer_staggered")
	
	
	for body in $Area2D_Stop.get_overlapping_bodies():
		if body.name == "Player":
			area_player = true
			if enemy.action == "follow":
				enemy.action = "attack"
			elif enemy.action in ["attack", "reload"]:
				if stagger_attack == true:
					enemy.action = "reload"
				else:
					enemy.action = "attack"


func _on_Area2D_Boss_Red_area_entered(area):
	enemy._take_dmg(area, $audio_cut_dmg_1, $audio_cut_dmg_2, $audio_smash_dmg_1, 
	$audio_dmg_1, $audio_dmg_2, $audio_dmg_3, $audio_dmg_4)
	if enemy.life <= 0:
		enemy._dead($Body/Animation_Full, $Area2D_Ground_0/CollisionShape2D, self, 
		$Area2D_Boss_Red, "dead", "dead", "dead",
		"dead")


func _on_Area2D_Follow_body_entered(body):
	enemy._follow(body)


func _on_Area2D_Follow_body_exited(body):
	enemy._follow(body)


func _on_Area2D_Stop_body_entered(body):
	pass


func _on_Area2D_Stop_body_exited(body):
	area_player = false



func _on_Animation_Full_animation_finished(anim_name):
	enemy._flip($Body)
	if enemy.target:
		if area_player == false:
			enemy._follow(enemy.target)
	if anim_name in ["hammer_staggered"]:
		enemy._animation_over("staggered")


func _on_Animation_Upper_animation_finished(anim_name):
	enemy._flip($Body)
	if enemy.target:
		if area_player == false:
			enemy._follow(enemy.target)
	if anim_name in ["hammer_idle"]:
		enemy._animation_over("idle")
	if anim_name == "hammer_stagger":
		enemy._animation_over("reload")
		stagger_attack = false
		$Timer_stagger_attack.start()


func _on_Animation_Lower_animation_finished(anim_name):
	enemy._animation_over(anim_name)


func _on_Area2D_Hammer_area_entered(area):
	if enemy.life > 0:
		if area.name == "Area2D_Player":
			if enemy.layer[0] in LAYER.playerLayer ||  enemy.layer[1] in LAYER.playerLayer:
				if enemy.staggered == false:
						if Global.block == true && Global.flip != enemy.flip:
							if Global.stamina >= 20:
								if blocked == false:
									Global.stamina -= 20
									Global.blocked = true
							else:
								Global.life -= 20
								Global.stamina -= 20
								Global.hit = "attack"
						else:
							if Global.dodge == false && blocked == false:
								Global.life -= 20
								Global.hit = "attack"


func _on_Area2D_Hammer_stagger_area_entered(area):
	if enemy.life > 0:
		if area.name == "Area2D_Player":
			if enemy.layer[0] in LAYER.playerLayer ||  enemy.layer[1] in LAYER.playerLayer:
				if enemy.staggered == false:
					if Global.dodge == false:
						Global.life -= 10
						Global.staggered = true
						Global.hit = "attack"


func _on_Timer_stagger_attack_timeout():
	stagger_attack = true
