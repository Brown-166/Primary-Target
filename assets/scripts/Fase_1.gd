extends Node2D
const ENEMY = preload("res://assets/characters/Enemy_AR.tscn")
var i = false

func _ready():
	Global.fase = "Fase_1"
	$CanvasLayer/ProgressBar.visible = false
	DB._save_new_game(DB.current_save)
	

func _physics_process(delta):
	$CanvasLayer/ProgressBar.value = $CanvasLayer/ProgressBar.get_parent().get_parent().get_node("Boss_Red").life
	if i == true:
		$Area2D/CollisionShape2D.disabled = true
	
	if get_node("Boss_Red").life <= 0:
		if $CanvasLayer/Timer.is_stopped() == true:
			$CanvasLayer/Timer.start()
			Global.arsenal[1] = "hammer"
	
	if Global.dead == true:
		$AnimationPlayer.play("game_over")

func _on_Area2D_body_entered(body):
	if body.name == "Player":
#		DB._save_new_game(DB.current_save)
#		print("save")
		var enemy = ENEMY.instance()
		enemy.position.x = 3698
		enemy.position.y = 524
		add_child(enemy)
		$Area2D/CollisionShape2D.queue_free()
#		i = true
		pass



func _on_VisibilityNotifier2D_screen_entered():
	$CanvasLayer/ProgressBar.visible = true


func _on_Timer_timeout():
	$CanvasLayer/ProgressBar.visible = false
	$AnimationPlayer.play("loading_out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "game_over":
		get_tree().change_scene("res://assets/interfaces/game_over.tscn")
	if anim_name == "loading_out":
		get_tree().change_scene("res://assets/scenes/Fase_2.tscn")
