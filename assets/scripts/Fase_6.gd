extends Node2D





func _ready():
	Global.fase = "Fase_6"
	DB._save_new_game(DB.current_save)
	$Camera_Fase_6.current = true


func _physics_process(delta):
	$Camera_Fase_6.position.x = $Player.position.x + 395


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "game_over":
		get_tree().change_scene("res://assets/interfaces/game_over.tscn")
	if anim_name == "loading_out":
		get_tree().change_scene("res://assets/cutscenes/cutscene_7.tscn")


func _on_Area2D_Next_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("loading_out")
