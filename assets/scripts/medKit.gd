extends Node2D

var layer : Array


func _on_AudioStreamPlayer2D_finished():
	queue_free()


func _set_layer(L):
	layer = L
	z_index = L[0] * -1

func _physics_process(delta):
	for area in $Area2D.get_overlapping_areas():
		if area.name == "Area2D_Player":
			if layer[0] in LAYER.playerLayer || layer[1] in LAYER.playerLayer:
				Global.medKit += 1
				$Sprite.play("default")
				$Area2D/CollisionShape2D.disabled = true
				$AudioStreamPlayer2D.play()


