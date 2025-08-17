extends Node
class_name EnemyComponent

@export var enemy : Enemy

var _enemy : Enemy

func _ready():
	self._enemy = enemy if enemy != null else $".."
	self._enemy.EnemyReady \
		.subscribe(func(__): _on_enemy_ready()) \
		.dispose_with(self)

## Override to initialize player effects
func _on_enemy_ready():
	pass
