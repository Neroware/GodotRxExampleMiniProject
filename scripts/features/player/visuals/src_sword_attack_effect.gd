extends PlayerComponent
class_name PlayerSpriteSwordAttackEffect

@onready var anim : AnimationPlayer = $AnimationPlayer

func _on_player_ready():
	player_manager.Abilities.SwordAttackState \
		.filter(func(value): return value == player_manager.Abilities.EAbilityState.Active) \
		.subscribe(func(__): on_attack()) \
		.dispose_with(self)

func on_attack():
	var target : Vector2 = player.get_viewport().get_mouse_position()
	var d = player.position - target
	if abs(d.x) < abs(d.y):
		d.x = 0.0
	else:
		d.y = 0.0
	var angle = Vector2(0, -1).angle_to(d)
	self.rotation = angle
	
	anim.stop()
	anim.play("attack", -1, player.attack_speed)
