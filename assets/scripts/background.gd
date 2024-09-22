extends Sprite

export var velocidade = 1.0
var larguraInicial = 0.0
func _ready():
	larguraInicial = texture.get_width() * scale.x
	
func _physics_process(delta):
	position.x = position.x - velocidade
	if position.x <- larguraInicial:
		position.x = position.x + larguraInicial * 2
