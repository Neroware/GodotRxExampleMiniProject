extends EnemyComponent
class_name DummyEnemy

@export @onready var life = $"../Life"

func _on_enemy_ready():
	var enemy = self._enemy
	var life : Life = self.life
	
	GDRx.on_physics_process_as_observable(self) \
		.filter(func(__): return PlayerManager.singleton().get_player() != null) \
		.map(func(__): return (PlayerManager.singleton().get_player().position - enemy.position).normalized()) \
		.subscribe(func(d): on_move(enemy, d)) \
		.dispose_with(self)
	
	life.Defeated.subscribe(func(__): on_defeat()).dispose_with(self)
	
	self.life.Hp \
		.skip(1) \
		.filter(func(tup : Tuple): return tup.at(1) < tup.at(0)) \
		.map(func(tup : Tuple): return tup.at(0) - tup.at(0)) \
		.subscribe(on_hit) \
		.dispose_with(self)

func on_move(enemy : Enemy, d : Vector2):
	var delta = enemy.get_physics_process_delta_time()
	var v = enemy.movement_speed * d.normalized()
	var a = v - enemy.velocity
	var accel = clamp(
		delta * enemy.movement_acceleration, 
		0.0, 
		(v - enemy.velocity).length()
	)
	enemy.velocity += accel * a.normalized()
	enemy.move_and_slide()

func on_defeat():
	enemy.queue_free()

func on_hit(damage : int):
	pass
