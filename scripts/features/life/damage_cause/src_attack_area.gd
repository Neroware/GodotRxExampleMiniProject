extends DamageCause
class_name AttackArea

@export @onready var sensor_node : Node
@export var enabled_on_start : bool = false

@onready var _sensor : SensorBase = sensor_node as SensorBase

func _ready():
	self.set_enabled(enabled_on_start)
	self._sensor.SensorTriggered.subscribe(self.on_hit).dispose_with(self)

func set_enabled(enabled : bool):
	self._sensor.set_enabled(enabled)

func is_enabled() -> bool:
	return self._sensor.is_enabled()

func on_hit(body : PhysicsBody2D):
	if body.has_node("DamageEffects"):
		var damage_effects : Node = body.get_node("DamageEffects")
		for eff in damage_effects.get_children():
			eff.trigger(self)
	elif body.has_node("DamageEffect"):
		var eff : DamageEffect = body.get_node("DamageEffect")
		eff.trigger(self)
	
