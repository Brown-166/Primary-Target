extends Control

var speed = 200
var velocity = Vector2.ZERO

func _physics_process(delta):
	$Label.text = String(Global.medKit)
	if Global.life <= 0:
		$AnimatedSprite.play("L0")
	if Global.life > 0 && Global.life <= 10:
		$AnimatedSprite.play("L1")
	if Global.life >= 11 && Global.life <= 20:
		$AnimatedSprite.play("L2")
	if Global.life >= 21 && Global.life <= 30:
		$AnimatedSprite.play("L3")
	if Global.life >= 31 && Global.life <= 40:
		$AnimatedSprite.play("L4")
	if Global.life >= 41 && Global.life <= 50:
		$AnimatedSprite.play("L5")
	if Global.life >= 51 && Global.life <= 60:
		$AnimatedSprite.play("L6")
	if Global.life >= 61 && Global.life <= 70:
		$AnimatedSprite.play("L7")
	if Global.life >= 71 && Global.life <= 80:
		$AnimatedSprite.play("L8")
	if Global.life >= 81 && Global.life <= 90:
		$AnimatedSprite.play("L9")
	if Global.life >= 91 && Global.life <= 100:
		$AnimatedSprite.play("L10")
	
	
	if Global.block == false:
		if $Timer_Stamina.is_stopped() == true:
			if $Timer.is_stopped() == true:
				$Timer.start()
	else:
		$Timer_Stamina.stop()
	
	
	$ProgressBar.value = Global.stamina


func _on_Timer_timeout():
	$Timer_Stamina.start()


func _on_Timer_Stamina_timeout():
	Global.stamina += 2
