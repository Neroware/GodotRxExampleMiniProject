extends DamageEffect
class_name SpriteOnHitHighlightDamageEffect

@export var sprite_paths : Array[NodePath]
var _sprites : Array[CanvasItem]

@export var duration : float = 0.5
@export var highlight_frequency : float = 100.0

@export var highlight_color : Color = Color(1, 0, 0)

func _ready():
	super._ready()
	for path in sprite_paths:
		_sprites.append(get_node(path))

func trigger(damage_cause : DamageCause):
	var highlight = func():
		for sprite in self._sprites:
			if sprite.modulate == highlight_color:
				sprite.modulate = Color(1, 1, 1)
			else:
				sprite.modulate = highlight_color
	
	var reset = func():
		for sprite in self._sprites:
			sprite.modulate = Color(1, 1, 1)
	
	GDRx.on_process_as_observable(self) \
		.take_until(GDRx.start_timer(duration, GDRx.timeout.Inherit)) \
		.take_until(self._life.Hp.skip(1)) \
		.debounce(1.0 / highlight_frequency) \
		.subscribe(
			func(__): highlight.call(), func(__):return, reset) \
		.dispose_with(self)
