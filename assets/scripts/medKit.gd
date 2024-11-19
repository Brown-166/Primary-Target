extends Node2D

var layer : int


func _on_AudioStreamPlayer2D_finished():
	queue_free()


func _set_layer(L):
	layer = L
	z_index = L * -1

func _physics_process(delta):
	print(layer)
	for area in $Area2D.get_overlapping_areas():
#		layer = LAYER._get_layer(area.name, layer)
#		z_index = LAYER._get_z_index(area.name, z_index)
		if area.name == "Area2D_Player" && layer == LAYER.playerLayer:
			Global.medKit += 1
			$Sprite.play("default")
			$Area2D/CollisionShape2D.disabled = true
			$AudioStreamPlayer2D.play()


