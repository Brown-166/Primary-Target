extends Area2D




func _on_katana_body_entered(body):
	if body.name == "Jogador":
		Global.katana = true
		queue_free()
