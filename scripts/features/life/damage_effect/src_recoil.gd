extends DamageEffect
class_name RecoilDamageEffect

@export var body : NodePath = "../.."
var _body : CharacterBody2D

@export var recoil_scale : float = 100.0
@export var recoil_damage_scale : float = 10.0
@export var recoil_player_velocity_scale : float = 1.0

func _ready():
	super._ready()
	var body_node = get_node(body)
	self._body = body_node

func trigger(damage_cause : DamageCause):
	var player : Player = PlayerManager.singleton().get_player()
	var d = (self._body.position - player.position).normalized()
	
	var recoil = recoil_player_velocity_scale * player.velocity + \
		recoil_damage_scale * d + \
		recoil_scale * d
	
	self._body.velocity = recoil
