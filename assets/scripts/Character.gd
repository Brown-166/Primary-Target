extends KinematicBody2D

class_name Character


var body_parts : Array 


var flip = false


func _set_body(B):
	for i in B.get_child_count():
		body_parts.append(B.get_child(i))
		for j in B.get_child(i).get_child_count():
			body_parts.append(B.get_child(i).get_child(j))
			for k in B.get_child(i).get_child(j).get_child_count():
				body_parts.append(B.get_child(i).get_child(j).get_child(k))
				for l in B.get_child(i).get_child(j).get_child(k).get_child_count():
					body_parts.append(B.get_child(i).get_child(j).get_child(k).get_child(l))



func _flip(B):
	if flip == false:
		B.scale.x = 1
	else:
		B.scale.x = -1


