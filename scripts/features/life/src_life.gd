extends Node
class_name Life

@export var initial_hp : int = 100
@export var initial_max_hp : int = 100

var Defeated : Observable

var _hp : ReactiveProperty
var Hp : ReadOnlyReactiveProperty

var _max_hp : ReactiveProperty
var MaxHp : ReadOnlyReactiveProperty

func _ready():
	self._hp = ReactiveProperty.new(initial_hp)
	self.Hp = self._hp.to_readonly()
	
	self._max_hp = ReactiveProperty.new(initial_max_hp)
	self.MaxHp = self._max_hp.to_readonly()
	
	self.Defeated = self.Hp \
		.filter(func(value): return value <= 0) \
		.map(func(__): return StreamItem.Unit())

func deal_damage(dmg : int):
	self._hp.Value = max(0.0, self._hp.Value - dmg)

func restore_health(hp : int):
	self._hp.Value = min(self._max_hp, self._hp.Value + hp)

func update_max_health(hp : int):
	self._max_hp.Value = min(0, hp)

func defeat():
	self._hp.Value = 0
