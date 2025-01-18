extends CanvasLayer



func _ready():
	DB._load_DB()
	if DB.android_controller == true:
		self.visible = true
	$Control/Button_Katana.visible = false
	$Control/Button_Hammer.visible = false
	$Control/Button_Katar.visible = false
	$Control/Button_Block.visible = false
	$Control/Button_Stagger.visible = false
	$Control/Button_Dodge.visible = false
	if Global.arsenal[1] == "hammer":
		$Control/Button_Katana.visible = true
		$Control/Button_Hammer.visible = true
	if Global.arsenal[2] == "katar":
		$Control/Button_Katana.visible = true
		$Control/Button_Katar.visible = true
	
	
	


func _physics_process(delta):
	if DB.android_controller == true:
		self.visible = true
	else:
		self.visible = false
	if Global.fase in ["Fase_1", "Fase_3", "Fase_4", "Fase_6"]:
		$"Control/Virtual joystick".visible = true
		$"Control/Virtual joystick".rect_position = Vector2(50, 470)
		$Control/Button_Right.visible = false
		$Control/Button_Left.visible = false
		$Control/Button_Jump.visible = false
		$Control/Button_Attack.visible = true
	elif Global.fase == "Fase_2":
		$"Control/Virtual joystick".visible = false
		$"Control/Virtual joystick".rect_position = Vector2(0, 0)
		$Control/Button_Right.visible = true
		$Control/Button_Right.position = Vector2(280, 510)
		$Control/Button_Left.visible = true
		$Control/Button_Left.position = Vector2(210, 654)
		$Control/Button_Jump.visible = true
		$Control/Button_Attack.visible = true
	elif Global.fase == "Fase_5":
		$"Control/Virtual joystick".visible = false
		$"Control/Virtual joystick".rect_position = Vector2(0, 0)
		$Control/Button_Right.visible = true
		$Control/Button_Right.position = Vector2(850, 545)
		$Control/Button_Left.visible = true
		$Control/Button_Left.position = Vector2(430, 689)
		$Control/Button_Jump.visible = false
		$Control/Button_Attack.visible = false
	
	if Global.fase != "Fase_5":
		match Global.weapon:
			"katana":
				$Control/Button_Block.visible = true
				$Control/Button_Stagger.visible = false
				$Control/Button_Dodge.visible = false
			"hammer":
				$Control/Button_Block.visible = false
				$Control/Button_Stagger.visible = true
				$Control/Button_Dodge.visible = false
			"katar":
				$Control/Button_Block.visible = false
				$Control/Button_Stagger.visible = false
				$Control/Button_Dodge.visible = true
