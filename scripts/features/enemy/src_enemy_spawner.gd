extends Node2D
class_name Spawner

@export var enabled : bool = true
@export var spawned_scene : PackedScene = preload("res://scenes/features/enemies/scn_dummy_enemy.tscn")

@export @onready var root_node : Node = $".."

var spawned_entity : Node = null

func _process(delta):
	if enabled and spawned_entity == null:
		spawned_entity = spawned_scene.instantiate()
		spawned_entity.name = "SpawnedEntity" + str(spawned_entity.get_instance_id())
		spawned_entity.position = self.position
		root_node.add_child(spawned_entity)
