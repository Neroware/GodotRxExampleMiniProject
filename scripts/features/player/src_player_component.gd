extends Node
class_name PlayerComponent

@onready var player : Player = Globals.current_player

func _ready():
	self.player.PlayerReady.subscribe(func(__): self._on_player_ready())

func _on_player_ready():
	GDRx.exc.NotImplementedException.Throw()
