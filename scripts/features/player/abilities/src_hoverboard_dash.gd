extends PlayerComponent
class_name PlayerHoverboardDash

var _chain : ReactiveProperty = ReactiveProperty.new(0)
var Chain : ReadOnlyReactiveProperty = self._chain.to_readonly()

func _on_player_ready():
	var input_actions = InputActionManager.singleton()
	var _R_ = PlayerAbilityManager.EAbilityState.Ready
	
	input_actions.Dash \
		.filter(func(__): return player_manager.Abilities.DashState.Value == _R_) \
		.process_time_interval() \
		.do_after_next(
			func(tup : Tuple):
				var dt : float = tup.at(1)
				if self._chain.Value < player.dash_chain_length - 1:
					self._chain.Value += 1
					player_manager.Abilities.activate("Dash", player.dash_duration, _R_)
					GDRx.start_timer(player.dash_chain_window, GDRx.timeout.Inherit) \
						.take_until(self._chain.skip(1)) \
						.subscribe(func(__): self._chain.Value = 0)
				else:
					self._chain.Value = 0
					player_manager.Abilities.activate_with_cooldown(
						"Dash", player.dash_duration, player.dash_cooldown)
				) \
		.subscribe(func(__): self.on_dash()) \
		.dispose_with(self)

func on_dash():
	player.velocity = player.movement_speed * player.velocity.normalized()
	player.velocity += player.dash_energy * player.velocity
