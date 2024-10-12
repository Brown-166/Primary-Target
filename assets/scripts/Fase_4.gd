extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.fase = "Fase_4"
	$Camera_Fase_4.current = true


func _physics_process(delta):
	$CanvasLayer/ProgressBar.value = $CanvasLayer/ProgressBar.get_parent().get_parent().get_node("Boss_Blue").life
	
	if get_node("Boss_Blue").life <= 0:
		if $CanvasLayer/Timer.is_stopped() == true:
			$CanvasLayer/Timer.start()
	
	if Global.dead == true:
		$AnimationPlayer.play("game_over")


func _on_Timer_timeout():
	$CanvasLayer/ProgressBar.visible = false
	$AnimationPlayer.play("loading_out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "game_over":
		get_tree().change_scene("res://assets/interfaces/game_over.tscn")
	if anim_name == "loading_out":
		get_tree().change_scene("res://assets/interfaces/credits.tscn")
