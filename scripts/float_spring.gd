## Ryan Juckett's spring code 
## https://www.ryanjuckett.com/damped-springs/

class_name FloatSpring

const EPSILON := 0.0001

## how fast the spring moves towards the target
var frequency: float = 0.0
## how bouncy the sping is (0 = infinite, 1 = no bounce)
var damping: float = 0.0
var position: float = 0.0
var velocity: float = 0.0


func _init(p_frequency: float, p_damping: float) -> void:
	frequency = p_frequency
	damping = p_damping


func reset(new_position: float, new_velocity: float = 0.0) -> void:
	position = new_position
	velocity = new_velocity


func update(delta: float, target: float) -> float:
	var angular_frequency := maxf(0, frequency)
	var damp_ratio := maxf(0, damping)

	var pos_pos_coef := 0.0
	var pos_vel_coef := 0.0
	var vel_pos_coef := 0.0
	var vel_vel_coef := 0.0

	if angular_frequency < EPSILON:
		pos_pos_coef = 1
		vel_pos_coef = 0
		pos_vel_coef = 0
		vel_vel_coef = 1
	elif damp_ratio > 1 + EPSILON:
		# overdamped
		var za := -angular_frequency * damp_ratio
		var zb := angular_frequency * sqrt(damp_ratio * damp_ratio - 1.0)
		var z1 := za - zb
		var z2 := za + zb

		var e1 := exp(z1 * delta)
		var e2 := exp(z2 * delta)

		var inv_two_zb := 1.0 / (2.0 * zb)

		var e1_over_two_zb := e1 * inv_two_zb
		var e2_over_two_zb := e2 * inv_two_zb

		pos_pos_coef = e1_over_two_zb * z2 - e2_over_two_zb + e2
		pos_vel_coef = -e1_over_two_zb + e2_over_two_zb
		vel_pos_coef = (e1_over_two_zb - e2_over_two_zb + e2) * z2
		vel_vel_coef = -e1_over_two_zb + e2_over_two_zb
	elif damp_ratio < 1.0 - EPSILON:
		# underdamped
		var omega_zeta := angular_frequency * damp_ratio
		var alpha := angular_frequency * sqrt(1.0 - damp_ratio * damp_ratio)

		var exp_term := exp(-omega_zeta * delta)
		var cos_term := cos(alpha * delta)
		var sin_term := sin(alpha * delta)

		var inv_alpha := 1.0 / alpha

		var exp_sin := exp_term * sin_term
		var exp_cos := exp_term * cos_term
		var exp_omega_zeta_sin_over_alpha := exp_term * omega_zeta * sin_term * inv_alpha

		pos_pos_coef = exp_cos + exp_omega_zeta_sin_over_alpha
		pos_vel_coef = exp_sin * inv_alpha
		vel_pos_coef = -exp_sin * alpha - omega_zeta * exp_omega_zeta_sin_over_alpha
		vel_vel_coef = exp_cos - exp_omega_zeta_sin_over_alpha
	else:
		# critically damped
		var exp_term := exp(-angular_frequency * delta)
		var time_exp := delta * exp_term
		var time_exp_freq := time_exp * angular_frequency

		pos_pos_coef = time_exp_freq + exp_term
		pos_vel_coef = time_exp
		vel_pos_coef = -angular_frequency * time_exp_freq
		vel_vel_coef = -time_exp_freq + exp_term

	# Update state
	var old_pos := position - target
	var old_vel := velocity

	position = old_pos * pos_pos_coef + old_vel * pos_vel_coef + target
	velocity = old_pos * vel_pos_coef + old_vel * vel_vel_coef
	
	return position
