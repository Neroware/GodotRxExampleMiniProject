extends CharacterBody2D
class_name Enemy

@export var movement_speed : float = 90.0
@export var movement_acceleration : float = 250.0

signal enemy_ready
var EnemyReady : Observable

func _init():
	EnemyReady = GDRx.from_signal(self.enemy_ready)

func _ready():
	enemy_ready.emit()
