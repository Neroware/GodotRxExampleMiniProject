extends PlayerComponent
class_name PlayerHoverboardDash

func _on_player_ready():
	var input_actions = InputActionManager.singleton()
	var gss : GodotSignalScheduler = GodotSignalScheduler.singleton()
	
	var _R_ = PlayerManager.EAbilityState.READY
	var _A_ = PlayerManager.EAbilityState.ACTIVE
	var _CD_ = PlayerManager.EAbilityState.COOLDOWN
	
	var chain = RefValue.Set(0)
	input_actions.Dash \
		.filter(func(__): return player_manager.Abilities.dash_state.Value == _R_) \
		.subscribe(func(__): self.on_dash())


func on_dash():
	player.velocity = player.movement_speed * player.velocity.normalized()
	player.velocity += player.dash_energy * player.velocity
