extends Node
class_name PlayerComponent

@onready var player : Player = Globals.current_player
@onready var player_manager : PlayerManager = PlayerManager.singleton()

func _ready():
	self.player.PlayerReady.subscribe(
		func(__): self._on_player_ready()).dispose_with(self)

func _on_player_ready():
	GDRx.exc.NotImplementedException.Throw()
