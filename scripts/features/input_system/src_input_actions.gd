class_name InputActionManager

## Character Directional Movement ([Vector2])
var Move : Observable
## Dash in movement direction ([StreamItem.Unit])
var Dash : Observable
## Attack with cursor target ([Vector2])
var Attack : Observable

static func singleton() -> InputActionManager:
	return Globals.InputActionManager_

func _init():
	var root = Globals.Root
	
	self.Move = GDRx.on_physics_process_as_observable(root) \
		.map(func(delta): return Input.get_vector("Left", "Right", "Up", "Down"))
	
	self.Dash = GDRx.on_input_as_observable(root) \
		.filter(func(ev : InputEvent): return ev.is_action_pressed("Action1")) \
		.map(func(__): return StreamItem.Unit())
	
	self.Attack = GDRx.input_action(
		"Action0",
		GDRx.on_physics_process_as_observable(root)) \
		.filter(func(i): return i == 2) \
		.map(func(__): return Globals.get_viewport().get_mouse_position())
