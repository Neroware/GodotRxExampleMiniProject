extends Node
class_name DamageEffect

@export var life : NodePath = "../../Life"
var _life : Life

func _ready():
	var life_node = get_node(life)
	self._life = life_node

func trigger(damage_cause : DamageCause):
	#print("Hit! ", damage_cause.damage)
	self._life.deal_damage(damage_cause.damage)
