extends KinematicBody2D

class_name Character


var body_parts : Array 
#[$Body/Chest, $Body/Chest/Chest_DMG, 
#$Body/Chest/Head, $Body/Chest/Head/Head_DMG,
#$Body/Chest/L_Arm, $Body/Chest/L_Arm/L_Arm_DMG,
#$Body/Chest/L_Arm/L_Forearm, $Body/Chest/L_Arm/L_Forearm/L_Forearm_DMG, 
#$Body/Chest/L_Arm/L_Forearm/L_Hand,
#$Body/Chest/R_Arm, $Body/Chest/R_Arm/R_Arm_DMG,
#$Body/Chest/R_Arm/R_Forearm, $Body/Chest/R_Arm/R_Forearm/R_Forearm_DMG, 
#$Body/Chest/R_Arm/R_Forearm/R_Hand,
#$Body/Chest/L_Thigh, $Body/Chest/L_Thigh/L_Thigh_DMG,
#$Body/Chest/L_Thigh/L_Leg, $Body/Chest/L_Thigh/L_Leg/L_Leg_DMG,
#$Body/Chest/L_Thigh/L_Leg/L_Foot,
#$Body/Chest/R_Thigh, $Body/Chest/R_Thigh/R_Thigh_DMG,
#$Body/Chest/R_Thigh/R_Leg, $Body/Chest/R_Thigh/R_Leg/R_Leg_DMG,
#$Body/Chest/R_Thigh/R_Leg/R_Foot
#]

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


