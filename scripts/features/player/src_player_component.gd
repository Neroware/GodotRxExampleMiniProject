extends Node
class_name PlayerComponent

@export var player_node : Node
var player : Player

func _ready():
	self.player = player_node as Player
	self.player.PlayerReady.subscribe(func(__): self._on_player_ready())

func _on_player_ready():
	GDRx.exc.NotImplementedException.Throw()
