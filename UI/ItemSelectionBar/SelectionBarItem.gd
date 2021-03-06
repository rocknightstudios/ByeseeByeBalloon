extends TextureRect

var alpha_must_be_managed = true # While this item is not dropped manage it's alpha.

const BLINK_PHASE = .02 # How quickly to blink the bottom line.

func _ready():
	set_material(get_material().duplicate(true))

func modulate_bar_on_player_being_too_low(goal_c, goal_a):
	self_modulate.a = goal_a
	self_modulate.b = goal_c
	self_modulate.g = goal_c

func _process(delta):
	if alpha_must_be_managed:
		if get_parent().player_is_in_danger:
			modulate_bar_on_player_being_too_low(abs(sin(OS.get_ticks_msec() * BLINK_PHASE)), 1.0 - get_parent().player_danger_alpha_coefficient)
		else:
			modulate_bar_on_player_being_too_low(1.0, 1.0)
