extends PlayerComponent
class_name PlayerSpriteHoverboardSwordAttackAnimationController

@onready var board_sprite : AnimatedSprite2D = $HoverBoardSprite
@onready var space_girl_sprite : AnimatedSprite2D = $SpaceGirlSprite

func _on_player_ready():
	var _A_ = PlayerAbilityManager.EAbilityState.Active
	
	board_sprite.play("default")
	space_girl_sprite.play("default")
	player_manager.Abilities.SwordAttackState \
		.filter(func(value): return value == _A_) \
		.subscribe(func(__): on_attack()) \
		.dispose_with(self)
	GDRx.from_signal(space_girl_sprite.animation_finished)  \
		.subscribe(func(__):
			space_girl_sprite.speed_scale = 1.0
			space_girl_sprite.play("default")) \
		.dispose_with(self)

func on_attack():
	var target : Vector2 = player.get_viewport().get_mouse_position()
	var d = player.position - target
	space_girl_sprite.speed_scale = player.attack_speed
	space_girl_sprite.frame = 0
	if abs(d.x) < abs(d.y):
		if d.y < 0.0:
			space_girl_sprite.play("attack_down")
		else:
			space_girl_sprite.play("attack_up")
	else:
		if d.x > 0.0:
			space_girl_sprite.play("attack_left")
		else:
			space_girl_sprite.play("attack_right")
