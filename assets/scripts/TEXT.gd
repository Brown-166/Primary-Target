extends Node

var language = "Português"

var Skill_Tree_katana
var Skill_Tree_hammer
var Skill_Tree_katar
var Skill_Tree_axe
var Skill_Tree_tonfa
var Skill_Tree_wakizashi
var Skill_Tree_great_sword


var buy
var equip
var equiped



func _ready():
	pass

func _physics_process(delta):
	if language == "Português":
		buy = "COMPRAR"
		equip = "EQUIPAR"
		equiped = "EQUIPADO"
		
		Skill_Tree_katana = """Classe: Médio
		 Arma: Katana
		
		 Atributos:
		   velocidade de ataque: 
		   normal
		   velocidade de movimento:
		   normal
		
		 Abilidades: 
		   Bloqueio"""
		
		Skill_Tree_hammer = """Classe: Pesado
		 Arma: Martelo
		
		 Atributos:
		   velocidade de ataque: 
		   lento
		   velocidade de movimento:
		   lento
		
		 Abilidades: 
		   Derrubar inimigo"""
		
		Skill_Tree_katar = """Classe: Leve
		 Arma: Katar
		
		 Atributos:
		   velocidade de ataque: 
		   rápido
		   velocidade de movimento:
		   rápido
		
		 Abilidades: 
		   Esquiva"""
		
		Skill_Tree_axe = """Classe: Médio-Pesado
		 Arma: Machado
		
		 Atributos:
		   velocidade de ataque: 
		   normal
		   velocidade de movimento:
		   lento
		
		 Abilidades: 
		   Bloqueio
		   Derrubar inimigo
		
		 Especial:
		   Parry"""
		
		Skill_Tree_tonfa = """Classe: Médio
		 Arma: Tonfa
		
		 Atributos:
		   velocidade de ataque: 
		   normal
		   velocidade de movimento:
		   rápido
		
		 Abilidades: 
		   Derrubar inimigo
		   Esquiva
		
		 Especial:
		   Dash"""
		
		Skill_Tree_wakizashi = """Classe: Leve-Médio
		 Arma: Wakizashi
		
		 Atributos:
		   velocidade de ataque: 
		   rápido
		   velocidade de movimento:
		   normal
		
		 Abilidades: 
		   Bloqueio
		   Esquiva
		
		 Especial:
		   Nitoryu"""
		
		Skill_Tree_great_sword = """Classe: ???
		 Arma: Espadão
		
		 Atributos:
		   velocidade de ataque: 
		   rápido
		   velocidade de movimento:
		   rápido
		
		 Abilidades: 
		   Bloqueio
		   Derrubar inimigo
		   Esquiva
		
		 Especial:
		   Corte de longo alcance"""
