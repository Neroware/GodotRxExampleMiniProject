class_name PlayerManager


var _player_properties : Dictionary
var _player : Player

var _ability_states : PlayerAbilityManager
var Abilities : PlayerAbilityManager:
	get: return self._ability_states

static func singleton() -> PlayerManager:
	return Globals.PlayerManager_

func _ready():
	self._player = null
	self._player_properties = {}

func get_player() -> Player:
	return self._player

var player : Player: 
	get: return self.get_player()

func reset():
	for player_property in self._player_properties:
		var ro_prop : ReadOnlyReactiveProperty = self._player_properties[player_property].at(1)
		ro_prop.dispose()
	self._player_properties.clear()
	self._player = null
	if self._ability_states != null:
		self._ability_states.dispose()

func update_player(player : Player):
	self.reset()
	
	for player_property in player.PLAYER_PROPERTIES:
		var prop = ReactiveProperty.FromMember(player, player_property)
		self._player_properties[player_property] = Tuple.new([
			prop,
			prop.to_readonly()
		])
	self._player = player
	self._ability_states = PlayerAbilityManager.new()

func get_property(player_property : String) -> ReadOnlyReactiveProperty:
	if not player_property in self._player_properties:
		GDRx.raise_message("Unknown Player Property!")
		return null
	return self._player_properties[player_property].at(1)

func set_property(player_property : String, value):
	if not player_property in self._player_properties:
		GDRx.raise_message("Unknown Player Property!")
		return
	self._player_properties[player_property].at(0).Value = value
