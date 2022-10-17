class_name PlayerAbilityManager

enum EAbilityState {
	Ready, Active, Cooldown
}

const ABILITY_NAMES = [
	"Dash", "SwordAttack"
]

var _ability_states : Dictionary

func _init():
	self._ability_states = {}
	for ability in self.ABILITY_NAMES:
		var prop = ReactiveProperty.new(EAbilityState.Ready)
		var ro_prop = prop.to_readonly()
		self._ability_states[ability] = Tuple.new([prop, ro_prop])

func get_state(ability : String) -> ReadOnlyReactiveProperty:
	return self._ability_states[ability].at(1)

func update_state(ability : String, value : EAbilityState):
	self._ability_states[ability].at(0).Value = value

func dispose():
	for ability in self.ABILITY_NAMES:
		self._ability_states[ability].at(0).dispose()

func start_cooldown(ability : String, duration : float):
	var prop : ReactiveProperty = self._ability_states[ability].at(0)
	prop.Value = EAbilityState.Cooldown
	GDRx.start_timer(duration, GDRx.timeout.Inherit) \
		.take_until(prop.skip(1)) \
		.subscribe(func(__): prop.Value = EAbilityState.Ready) \
		.dispose_with(self)

func activate(ability : String, duration : float = -1.0, next_state : EAbilityState = EAbilityState.Cooldown):
	self.update_state(ability, EAbilityState.Active)
	if duration >= 0.0:
		var prop : ReactiveProperty = self._ability_states[ability].at(0)
		GDRx.start_timer(duration, GDRx.timeout.Inherit) \
			.take_until(prop.skip(1)) \
			.subscribe(func(__): prop.Value = next_state) \
			.dispose_with(self)

func activate_with_cooldown(ability : String, active_duration : float = 0.0, cooldown_duration : float = 0.0):
	self.update_state(ability, EAbilityState.Active)
	var prop : ReactiveProperty = self._ability_states[ability].at(0)
	GDRx.start_timer(active_duration, GDRx.timeout.Inherit) \
		.take_until(prop.skip(1)) \
		.subscribe(func(__): self.start_cooldown(ability, cooldown_duration)) \
		.dispose_with(self)

# =========================================================================== #
#   Quick Access
# =========================================================================== #

var DashState : ReadOnlyReactiveProperty:
	get: return self.get_state("Dash")

var SwordAttackState : ReadOnlyReactiveProperty:
	get: return self.get_state("SwordAttack")
