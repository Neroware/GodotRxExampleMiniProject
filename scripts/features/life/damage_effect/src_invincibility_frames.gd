extends DamageEffect
class_name InvincibilityFramesDamageEffect

@export var body : NodePath = "../.."
var _body : CharacterBody2D

@export var invincibility_duration = 0.2 # in seconds

@export var effect_collision_layer : int = 0b100
@export var effect_collision_mask : int = 0b100

func _ready():
	super._ready()
	var body_node = get_node(body)
	self._body = body_node

func trigger(damage_cause : DamageCause):
	self._body.collision_layer ^= effect_collision_layer
	self._body.collision_mask ^= effect_collision_mask
	GDRx.start_timer(invincibility_duration) \
		.subscribe(
			func(__): 
				self._body.collision_layer |= effect_collision_layer
				self._body.collision_mask |= effect_collision_mask) \
		.dispose_with(self)
