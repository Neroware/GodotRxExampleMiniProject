extends PlayerComponent
class_name PlayerSwordAttack

var _chain : ReactiveProperty = ReactiveProperty.new(0)
var Chain : ReadOnlyReactiveProperty = self._chain.to_readonly()

func _on_player_ready():
	var input_actions = InputActionManager.singleton()
	var _R_ = PlayerAbilityManager.EAbilityState.Ready
	
	input_actions.Attack \
		.filter(func(__): return player_manager.Abilities.SwordAttackState.Value == _R_) \
		.process_time_interval() \
		.do_after_next(
			func(tup : Tuple):
				var dt : float = tup.at(1)
				if self._chain.Value < player.attack_chain_length:
					self._chain.Value += 1
					if self._chain.Value == 0 or dt > player.attack_chain_window:
						self._chain.Value = 1
					player_manager.Abilities.activate("SwordAttack", 1.0 / player.attack_speed, _R_)
				else:
					self._chain.Value = 0
					player_manager.Abilities.start_cooldown("SwordAttack", player.attack_cooldown)
				) \
		.subscribe(func(tup : Tuple): self.on_attack(tup.at(0))) \
		.dispose_with(self)


func on_attack(v : Vector2):
	var d = (player.position - v).normalized()
	if abs(d.x) > abs(d.y):
		d.y = 0.0
	else:
		d.x = 0.0
	player.velocity += player.attack_recoil * d
	
	var angle = Vector2(0, -1).angle_to(d)
	
	#var damage_area : DamageArea = player.damage_area
	#damage_area.rotation = angle
	#damage_area.enabled = true
	#GDRx.start_timer(1.0 / player.attack_speed) \
	#	.subscribe(func(__): damage_area.enabled = false) \
	#	.dispose_with(self)
