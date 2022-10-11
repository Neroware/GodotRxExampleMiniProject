extends Node

@onready var PlayerManager_ : PlayerManager = PlayerManager.new()

@onready var InputActionManager_ : InputActionManager = InputActionManager.new()

func get_root() -> Node:
	return self.get_node("/root")

var Root : Node: get = get_root
