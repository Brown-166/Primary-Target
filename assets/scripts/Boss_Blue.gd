extends KinematicBody2D


var enemy = Enemy.new(250, 1000, [250], [1], [1], [0], [1], [1])

var blocked = false

var ST = [3, 4, 4, 5]

var dodge = false
var dodge_charge = 60
var dodge_range = 625
var TIME = [1, 2, 3, 4, 5]
var dodge_time

var area_player = false

func _ready():
	enemy._set_body($Body)
	$Body/Animation_Lower.playback_speed = 2
	$Body/Animation_Upper.playback_speed = 2
	randomize()
	dodge_time = TIME[randi() % TIME.size()]
	$Timer_Dodge.wait_time = dodge_time
	$Timer_Dodge.start()


func _physics_process(delta):
	enemy._physics(delta, self, $Area2D_Ground_0, $Area2D_Ground_1, $RayCasts/Right, 
	$RayCasts/Left, $RayCasts/Up, $RayCasts/Down)
	if not enemy.action in ["attack", "reload"]:
		enemy._flip($Body)
	enemy._set_animation($Body/Animation_Lower, $Body/Animation_Upper, 
	$Body/Animation_Full, $audio_walk, "katar_idle", "", "katar_attack_1", 
	"katar_attack_2", "", "katar_staggered")
	
	
	for body in $Area2D_Stop.get_overlapping_bodies():
		if body.name == "Player":
			area_player = true
			if enemy.action == "follow":
				enemy.action = "attack"
			elif enemy.action in ["attack", "dodge"]:
				if dodge == true:
					enemy.action = "dodge"
				else:
					enemy.action = "attack"
	
	
	if enemy.action == "dodge":
		$Body/Animation_Lower.stop()
		$Body/Animation_Upper.stop()
		$Body/Animation_Full.play("katar_dodge")
		if enemy.flip == false:
			enemy.velocity.x += dodge_range
		else:
			enemy.velocity.x -= dodge_range
		enemy.velocity = enemy.velocity.normalized()
		move_and_collide(enemy.velocity * dodge_range * delta)


func _on_Area2D_Boss_Blue_area_entered(area):
	enemy._take_dmg(area, $audio_cut_dmg_1, $audio_cut_dmg_2, $audio_smash_dmg_1, 
	$audio_dmg_1, $audio_dmg_2, $audio_dmg_3, $audio_dmg_4)
	if enemy.life <= 0:
		enemy._dead($Body/Animation_Full, $Area2D_Ground_0/CollisionShape2D, self, 
		$Area2D_Boss_Blue, "dead", "dead", "dead",
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
	if anim_name in ["katar_staggered"]:
		enemy._animation_over("staggered")
	if anim_name == "katar_dodge":
		dodge = false
		dodge_charge -= 10
		randomize()
		dodge_time = TIME[randi() % TIME.size()]
		$Timer_Dodge.wait_time = dodge_time
		$Timer_Dodge.start()


func _on_Animation_Upper_animation_finished(anim_name):
	enemy._flip($Body)
	if enemy.target:
		if area_player == false:
			enemy._follow(enemy.target)
	if anim_name in ["katar_idle"]:
		enemy._animation_over("idle")


func _on_Animation_Lower_animation_finished(anim_name):
	enemy._animation_over(anim_name)


func _on_Area2D_Katar_area_entered(area):
	if enemy.life > 0:
		if area.name == "Area2D_Player":
			if enemy.layer[0] in LAYER.playerLayer ||  enemy.layer[1] in LAYER.playerLayer:
				if enemy.staggered == false:
						if Global.block == true && Global.flip != enemy.flip:
							if Global.stamina >= 10:
								if blocked == false:
									Global.stamina -= 10
									Global.blocked = true
							else:
								Global.life -= 5
								Global.stamina -= 10
								Global.hit = "attack"
						else:
							if Global.dodge == false && blocked == false:
								Global.life -= 5
								Global.hit = "attack"


func _on_Timer_Dodge_timeout():
	if dodge_charge >= 10:
		dodge = true


func _on_Timer_Dodge_charge_timeout():
	dodge_charge += 2
