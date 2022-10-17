extends SensorBase
class_name BodyEnteredSensor


## Area used to detect entering bodies
@export var area : Area2D = $"."
## If 'true', remebers lost detections, resets on deactivate
@export var detect_once = false

## Array of detections
var _detections : Array[PhysicsBody2D] = []


func _ready():
	self.SensorTriggered = GDRx.from_signal(area.body_entered)
	if detect_once:
		self.SensorTriggered = self.SensorTriggered \
			.do_after_next(func(body : PhysicsBody2D): self._detections.append(body)) \
			.filter(func(body : PhysicsBody2D): return not body in self._detections)


func set_enabled(enabled : bool):
	super.set_enabled(enabled)
	area.monitoring = enabled
	self._detections.clear()
