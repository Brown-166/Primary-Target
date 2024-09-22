extends Node2D


var weapon


func _ready():
	$Weapon_Tree/Control.visible = false
	
	
	

# warning-ignore:unused_argument
func _physics_process(delta):
	if Global.katana == true:
		$Weapon_Tree/Primary/Icon_Yellow.play("on")
	else:
		$Weapon_Tree/Primary/Icon_Yellow.play("off")
	if Global.hammer == true:
		$Weapon_Tree/Primary/Icon_Red.play("on")
	else:
		$Weapon_Tree/Primary/Icon_Red.play("off")
	if Global.katar == true:
		$Weapon_Tree/Primary/Icon_Blue.play("on")
	else:
		$Weapon_Tree/Primary/Icon_Blue.play("off")
	if Global.axe == true:
		$Weapon_Tree/Secondary/Icon_Orange.play("on")
	else:
		$Weapon_Tree/Secondary/Icon_Orange.play("off")
	if Global.tonfa == true:
		$Weapon_Tree/Secondary/Icon_Purple.play("on")
	else:
		$Weapon_Tree/Secondary/Icon_Purple.play("off")
	if Global.wakizashi == true:
		$Weapon_Tree/Secondary/Icon_Green.play("on")
	else:
		$Weapon_Tree/Secondary/Icon_Green.play("off")
	if Global.great_sword == true:
		$Weapon_Tree/Icon_White.play("on")
	else:
		$Weapon_Tree/Icon_White.play("off")



func _on_Button_Yellow_pressed():
	weapon = "katana"
	$Weapon_Tree/Control.visible = true
	$Weapon_Tree/Control/Label.text = TEXT.Skill_Tree_katana
	if Global.katana == false:
		$Weapon_Tree/Control/Button.text = TEXT.buy
	else:
		$Weapon_Tree/Control/Button.text = TEXT.equip
	if Global.weapon == "katana":
		$Weapon_Tree/Control/Button.text = TEXT.equiped


func _on_Button_Red_pressed():
	weapon = "hammer"
	$Weapon_Tree/Control.visible = true
	$Weapon_Tree/Control/Label.text = TEXT.Skill_Tree_hammer
	if Global.hammer == false:
		$Weapon_Tree/Control/Button.text = TEXT.buy
	else:
		$Weapon_Tree/Control/Button.text = TEXT.equip
	if Global.weapon == "hammer":
		$Weapon_Tree/Control/Button.text = TEXT.equiped


func _on_Button_Blue_pressed():
	weapon = "katar"
	$Weapon_Tree/Control.visible = true
	$Weapon_Tree/Control/Label.text = TEXT.Skill_Tree_katar
	if Global.katar == false:
		$Weapon_Tree/Control/Button.text = TEXT.buy
	else:
		$Weapon_Tree/Control/Button.text = TEXT.equip
	if Global.weapon == "katar":
		$Weapon_Tree/Control/Button.text = TEXT.equiped


func _on_Button_Orange_pressed():
	weapon = "axe"
	$Weapon_Tree/Control.visible = true
	$Weapon_Tree/Control/Label.text = TEXT.Skill_Tree_axe
	if Global.axe == false:
		$Weapon_Tree/Control/Button.text = TEXT.buy
	else:
		$Weapon_Tree/Control/Button.text = TEXT.equip
	if Global.weapon == "axe":
		$Weapon_Tree/Control/Button.text = TEXT.equiped


func _on_Button_Purple_pressed():
	weapon = "tonfa"
	$Weapon_Tree/Control.visible = true
	$Weapon_Tree/Control/Label.text = TEXT.Skill_Tree_tonfa
	if Global.tonfa == false:
		$Weapon_Tree/Control/Button.text = TEXT.buy
	else:
		$Weapon_Tree/Control/Button.text = TEXT.equip
	if Global.weapon == "tonfa":
		$Weapon_Tree/Control/Button.text = TEXT.equiped


func _on_Button_Green_pressed():
	weapon = "wakizashi"
	$Weapon_Tree/Control.visible = true
	$Weapon_Tree/Control/Label.text = TEXT.Skill_Tree_wakizashi
	if Global.wakizashi == false:
		$Weapon_Tree/Control/Button.text = TEXT.buy
	else:
		$Weapon_Tree/Control/Button.text = TEXT.equip
	if Global.weapon == "wakizashi":
		$Weapon_Tree/Control/Button.text = TEXT.equiped


func _on_Button_White_pressed():
	weapon = "great_sword"
	$Weapon_Tree/Control.visible = true
	$Weapon_Tree/Control/Label.text = TEXT.Skill_Tree_great_sword
	if Global.great_sword == false:
		$Weapon_Tree/Control/Button.text = TEXT.buy
	else:
		$Weapon_Tree/Control/Button.text = TEXT.equip
	if Global.weapon == "great_sword":
		$Weapon_Tree/Control/Button.text = TEXT.equiped


func _on_Button_pressed():
	if weapon == "katana":
		if $Weapon_Tree/Control/Button.text == TEXT.buy:
			Global.katana = true
			$Weapon_Tree/Control/Button.text = TEXT.equip
			if Global.hammer == true:
				$Weapon_Tree/AnimationPlayerOrange.play("Orange")
			if Global.katar == true:
				$Weapon_Tree/AnimationPlayerGreen.play("Green")
		if $Weapon_Tree/Control/Button.text == TEXT.equip:
			Global.weapon = "katana"
			$Weapon_Tree/Control/Button.text = TEXT.equiped
	if weapon == "hammer":
		if $Weapon_Tree/Control/Button.text == TEXT.buy:
			Global.hammer = true
			$Weapon_Tree/Control/Button.text = TEXT.equip
			if Global.katana == true:
				$Weapon_Tree/AnimationPlayerOrange.play("Orange")
			if Global.katar == true:
				$Weapon_Tree/AnimationPlayerPurple.play("Purple")
		if $Weapon_Tree/Control/Button.text == TEXT.equip:
			Global.weapon = "hammer"
			$Weapon_Tree/Control/Button.text = TEXT.equiped
	if weapon == "katar":
		if $Weapon_Tree/Control/Button.text == TEXT.buy:
			Global.katar = true
			$Weapon_Tree/Control/Button.text = TEXT.equip
			if Global.katana == true:
				$Weapon_Tree/AnimationPlayerGreen.play("Green")
			if Global.hammer == true:
				$Weapon_Tree/AnimationPlayerPurple.play("Purple")
		if $Weapon_Tree/Control/Button.text == TEXT.equip:
			Global.weapon = "katar"
			$Weapon_Tree/Control/Button.text = TEXT.equiped
	if weapon == "axe":
		if $Weapon_Tree/Control/Button.text == TEXT.buy:
			Global.axe = true
			$Weapon_Tree/Control/Button.text = TEXT.equip
			if Global.katana && Global.hammer && Global.katar && Global.axe && Global.tonfa && Global.wakizashi == true:
				$Weapon_Tree/AnimationPlayer.play("White")
		if $Weapon_Tree/Control/Button.text == TEXT.equip:
			Global.weapon = "axe"
			$Weapon_Tree/Control/Button.text = TEXT.equiped
	if weapon == "tonfa":
		if $Weapon_Tree/Control/Button.text == TEXT.buy:
			Global.tonfa = true
			$Weapon_Tree/Control/Button.text = TEXT.equip
			if Global.katana && Global.hammer && Global.katar && Global.axe && Global.tonfa && Global.wakizashi == true:
				$Weapon_Tree/AnimationPlayer.play("White")
		if $Weapon_Tree/Control/Button.text == TEXT.equip:
			Global.weapon = "tonfa"
			$Weapon_Tree/Control/Button.text = TEXT.equiped
	if weapon == "wakizashi":
		if $Weapon_Tree/Control/Button.text == TEXT.buy:
			Global.wakizashi = true
			$Weapon_Tree/Control/Button.text = TEXT.equip
			if Global.katana && Global.hammer && Global.katar && Global.axe && Global.tonfa && Global.wakizashi == true:
				$Weapon_Tree/AnimationPlayer.play("White")
		if $Weapon_Tree/Control/Button.text == TEXT.equip:
			Global.weapon = "wakizashi"
			$Weapon_Tree/Control/Button.text = TEXT.equiped
	if weapon == "great_sword":
		if $Weapon_Tree/Control/Button.text == TEXT.buy:
			Global.great_sword = true
			$Weapon_Tree/Control/Button.text = TEXT.equip
		if $Weapon_Tree/Control/Button.text == TEXT.equip:
			Global.weapon = "great_sword"
			$Weapon_Tree/Control/Button.text = TEXT.equiped
