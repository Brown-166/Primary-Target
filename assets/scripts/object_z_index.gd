extends Sprite


onready var player = get_parent().get_parent().get_parent().get_parent().get_node("Player")
onready var type = get_parent().name




func _physics_process(delta):
	if Global.fase == "Fase_6":
		if type == "containers":
			if player.global_position.x > global_position.x:
				z_index = -8
			else:
				z_index = -5
		elif type == "box":
			if player.global_position.x > global_position.x:
				z_index = -8
			else:
				z_index = -6
