extends PlayerComponent
class_name PlayerHoverboardMovement

func _on_player_ready():
	var input_actions = InputActionManager.singleton()
	# Movement
	input_actions.Move.subscribe(on_move).dispose_with(self)

func on_move(d : Vector2):
	var delta = player.get_physics_process_delta_time()
	var v = player.movement_speed * d.normalized()
	var a = v - player.velocity
	var accel = clamp(
		delta * player.movement_acceleration, 
		0.0, 
		(v - player.velocity).length()
	)
	player.velocity += accel * a.normalized()
	player.move_and_slide()
