extends CharacterBody2D
class_name Player

signal player_ready
var PlayerReady : Observable

## Export to [Observable]s in [PlayerManager] singleton
const PLAYER_PROPERTIES = [
	"movement_speed",
	"movement_acceleration",
	"dash_energy",
	"dash_chain_length",
	"dash_cooldown",
	"dash_duration",
	"dash_chain_window",
	"attack_speed",
	"attack_chain_length",
	"attack_cooldown",
	"attack_damage",
	"attack_chain_window",
	"attack_recoil"
]

# Movement
@export var movement_speed : float = 120.0
@export var movement_acceleration : float = 900.0

# Dash
@export var dash_energy : float = 2.5
@export var dash_chain_length : int = 2
@export var dash_cooldown : float = 3.0 # in seconds
@export var dash_duration : float = 0.2 # in seconds
@export var dash_chain_window : float = 1.0 # in seconds

# Attacking
@export var attack_speed = 2.5 # in attacks per second
@export var attack_chain_length : int = 2
@export var attack_cooldown : float = 0.4 # in seconds
@export var attack_damage : int = 10
@export var attack_chain_window : float = 1.0 # in seconds
@export var attack_recoil : float = 0.0

## Life
@onready var life = $Life
## Character Sprites
@onready var sprites = $CharacterSprites
## Damage Area
@onready var damage_area = $DamageArea

var _is_dead : bool = false

func _init():
	PlayerReady = GDRx.from_signal(self.player_ready)
	Globals.current_player = self

func _ready():
	var player_manager : PlayerManager = PlayerManager.singleton()
	player_manager.update_player(self)
	
	# Done! Notify other components that player is ready.
	player_ready.emit()
