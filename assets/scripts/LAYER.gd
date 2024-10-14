extends Node

var playerLayer :int = 0
var enemysLayer = [ 0, 0, 0 ]

func _physics_process(delta):
	#for i in enemysLayer.size():
		#print("layer " + String(i) + ":" + String(enemysLayer[i]))
	pass

func _get_layer(area, layer):
	match area:
		"Area2D_Ground":
			layer = 0
		"Layer_0":
			layer = 0
		"Layer_1":
			layer = 1
		"Layer_2":
			layer = 2
		"Layer_3":
			layer = 3
		"Layer_4":
			layer = 4
		"Layer_5":
			layer = 5
		"Layer_6":
			layer = 6
		"Layer_7":
			layer = 7
		"Layer_8":
			layer = 8
	return layer

func _get_z_index(area, z_index):
	match area:
		"Area2D_Ground":
			z_index = 0
		"Layer_0":
			z_index = 0
		"Layer_1":
			z_index = -1
		"Layer_2":
			z_index = -2
		"Layer_3":
			z_index = -3
		"Layer_4":
			z_index = -4
		"Layer_5":
			z_index = -5
		"Layer_6":
			z_index = -6
		"Layer_7":
			z_index = -7
		"Layer_8":
			z_index = -8
	return z_index




func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
