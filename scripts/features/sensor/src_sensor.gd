extends Node
class_name SensorBase

var SensorTriggered : Observable

var _enabled : bool

func _init():
	self._enabled = true

func set_enabled(enabled : bool):
	self._enabled = enabled

func is_enabled() -> bool:
	return self._enabled
