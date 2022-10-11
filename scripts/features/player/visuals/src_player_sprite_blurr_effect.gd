extends PlayerComponent
class_name PlayerSpriteBlurrEffect

@export var sprite_paths : Array[NodePath]
var _sprites : Array[CanvasItem]

func _ready():
	super._ready()
	for path in sprite_paths:
		_sprites.append(get_node(path))

func _on_player_ready():
	InputActionManager.singleton().Move.subscribe(on_move).dispose_with(self)

func on_move(d : Vector2):
	var filter_mode = 0 if d.length() < 0.1 or abs(d.x) < 0.1 or abs(d.y) < 0.1 else 2
	for sprite in _sprites:
		sprite.texture_filter = filter_mode
