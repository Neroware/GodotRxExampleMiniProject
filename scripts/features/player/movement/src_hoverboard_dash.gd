extends PlayerComponent
class_name PlayerHoverboardDash

var _chain : int = 0

func _on_player_ready():
	var input_actions = InputActionManager.singleton()
	var _R_ = PlayerAbilityManager.EAbilityState.Ready
	
	input_actions.Dash \
		.filter(func(__): return player_manager.Abilities.DashState.Value == _R_) \
		.process_time_interval() \
		.do_after_next(
			func(tup : Tuple):
				var dt : float = tup.at(1)
				if self._chain < player.dash_chain_length:
					self._chain += 1
					if self._chain == 0 or dt > player.dash_chain_window:
						self._chain = 1
					player_manager.Abilities.activate("Dash", player.dash_duration, _R_)
				else:
					self._chain = 0
					player_manager.Abilities.start_cooldown("Dash", player.dash_cooldown)
				) \
		.subscribe(func(__): self.on_dash()) \
		.dispose_with(self)

func on_dash():
	player.velocity = player.movement_speed * player.velocity.normalized()
	player.velocity += player.dash_energy * player.velocity
